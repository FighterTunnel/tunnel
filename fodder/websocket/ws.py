import socket, threading, select, signal, sys, time, getopt

# Listen
LISTENING_ADDR = '0.0.0.0'
if sys.argv[1:]:
    LISTENING_PORTS = [int(port) for port in sys.argv[1].split(',')]
else:
    LISTENING_PORTS = [10015]
# Passwd
PASS = ''

# CONST
BUFLEN = 4096 * 4
TIMEOUT = 60
DEFAULT_HOSTS = ['127.0.0.1:109', '127.0.0.1:2223', '127.0.0.1:2222', '127.0.0.1:1194']
RESPONSE = 'HTTP/1.1 101 Switching Protocol\r\nUpgrade: websocket\r\nConnection: Upgrade\r\nSec-WebSocket-Accept: foo\r\n\r\n'

class Server(threading.Thread):
    def __init__(self, host, ports):
        threading.Thread.__init__(self)
        self.running = False
        self.host = host
        self.ports = ports
        self.threads = []
        self.threadsLock = threading.Lock()
        self.logLock = threading.Lock()

    def run(self):
        self.socs = []
        for port in self.ports:
            soc = socket.socket(socket.AF_INET)
            soc.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            soc.settimeout(2)
            soc.bind((self.host, port))
            soc.listen(0)
            self.socs.append(soc)
        self.running = True

        try:
            while self.running:
                for soc in self.socs:
                    try:
                        c, addr = soc.accept()
                        c.setblocking(1)
                    except socket.timeout:
                        continue

                    conn = ConnectionHandler(c, self, addr)
                    conn.start()
                    self.addConn(conn)
        finally:
            self.running = False
            for soc in self.socs:
                soc.close()

    def printLog(self, log):
        self.logLock.acquire()
        print(log)
        self.logLock.release()

    def addConn(self, conn):
        try:
            self.threadsLock.acquire()
            if self.running:
                self.threads.append(conn)
        finally:
            self.threadsLock.release()

    def removeConn(self, conn):
        try:
            self.threadsLock.acquire()
            self.threads.remove(conn)
        finally:
            self.threadsLock.release()

    def close(self):
        try:
            self.running = False
            self.threadsLock.acquire()

            threads = list(self.threads)
            for c in threads:
                c.close()
        finally:
            self.threadsLock.release()


class ConnectionHandler(threading.Thread):
    def __init__(self, socClient, server, addr):
        threading.Thread.__init__(self)
        self.clientClosed = False
        self.targetClosed = True
        self.client = socClient
        self.client_buffer = ''
        self.server = server
        self.log = 'Connection: ' + str(addr)

    def close(self):
        try:
            if not self.clientClosed:
                self.client.shutdown(socket.SHUT_RDWR)
                self.client.close()
        except:
            pass
        finally:
            self.clientClosed = True

        try:
            if not self.targetClosed:
                self.target.shutdown(socket.SHUT_RDWR)
                self.target.close()
        except:
            pass
        finally:
            self.targetClosed = True

    def run(self):
        try:
            self.client_buffer = self.client.recv(BUFLEN).decode()

            hostPort = self.findHeader(self.client_buffer, 'X-Real-Host')

            if hostPort == '':
                hostPort = DEFAULT_HOSTS[0]

            split = self.findHeader(self.client_buffer, 'X-Split')

            if split != '':
                self.client.recv(BUFLEN)

            if hostPort != '':
                self.method_CONNECT(hostPort)
            else:
                print('- No X-Real-Host!')
                self.client.send('HTTP/1.1 400 NoXRealHost!\r\n\r\n'.encode())

        except Exception as e:
            self.log += ' - error: ' + str(e)
            self.server.printLog(self.log)
            pass
        finally:
            if not self.clientClosed:
                self.client.sendall(RESPONSE.encode())
            self.close()
            self.server.removeConn(self)

    def findHeader(self, head, header):
        aux = head.find(header + ': ')

        if aux == -1:
            return ''

        aux = head.find(':', aux)
        head = head[aux+2:]
        aux = head.find('\r\n')

        if aux == -1:
            return ''

        return head[:aux]

    def connect_target(self, host):
        i = host.find(':')
        if i != -1:
            port = int(host[i+1:])
            host = host[:i]
        else:
            if self.method == 'CONNECT':
                port = 443
            else:
                port = sys.argv[1]

        (soc_family, soc_type, proto, _, address) = socket.getaddrinfo(host, port)[0]

        self.target = socket.socket(soc_family, soc_type, proto)
        self.targetClosed = False
        self.target.connect(address)

    def method_CONNECT(self, path):
        self.log += ' - CONNECT ' + path

        self.connect_target(path)
        self.client.sendall(RESPONSE.encode())
        self.client_buffer = ''

        self.server.printLog(self.log)
        self.doCONNECT()

    def doCONNECT(self):
        socs = [self.client, self.target]
        count = 0
        error = False
        while True:
            count += 1
            (recv, _, err) = select.select(socs, [], socs, 3)
            if err:
                error = True
            if recv:
                for in_ in recv:
                    try:
                        data = in_.recv(BUFLEN)
                        if data:
                            if in_ is self.target:
                                self.client.send(data)
                            else:
                                while data:
                                    byte = self.target.send(data)
                                    data = data[byte:]

                            count = 0
                        else:
                            break
                    except:
                        error = True
                        break
            if count == TIMEOUT:
                error = True
            if error:
                break


def print_usage():
    print('Usage: proxy.py -p <port1,port2,...>')
    print('       proxy.py -b <bindAddr> -p <port1,port2,...>')
    print('       proxy.py -b 0.0.0.0 -p 80,443')

def parse_args(argv):
    global LISTENING_ADDR
    global LISTENING_PORTS
    
    try:
        opts, args = getopt.getopt(argv, "hb:p:", ["bind=", "port="])
    except getopt.GetoptError:
        print_usage()
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print_usage()
            sys.exit()
        elif opt in ("-b", "--bind"):
            LISTENING_ADDR = arg
        elif opt in ("-p", "--port"):
            LISTENING_PORTS = [int(port) for port in arg.split(',')]


def main(host=LISTENING_ADDR, ports=LISTENING_PORTS):
    print("\n:-------PythonProxy-------:\n")
    print("Listening addr: " + LISTENING_ADDR)
    print("Listening ports: " + ', '.join(map(str, LISTENING_PORTS)) + "\n")
    print(":-------------------------:\n")
    server = Server(LISTENING_ADDR, LISTENING_PORTS)
    server.start()
    while True:
        try:
            time.sleep(2)
        except KeyboardInterrupt:
            print('Stopping...')
            server.close()
            break

#######    parse_args(sys.argv[1:])
if __name__ == '__main__':
    main()
