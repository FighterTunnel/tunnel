import socket
from select import select

# immediately useful parameters are:
#   REMOTE_SERVER_NAME other network server (which will be resolved by DNS)
#   LOCAL_SERVER_PORT where forward network traffic to

REMOTE_SERVER_NAME = '8.8.8.8'
LOCAL_SERVER_PORT = 20
LOCAL_SERVER_NAME = '127.0.0.1'
REMOTE_PORT = 10030
LOCAL_PORT = REMOTE_PORT + 1

sock_remote = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock_remote.bind(('', REMOTE_PORT))
sock_remote.connect((REMOTE_SERVER_NAME, REMOTE_PORT))

sock_local = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock_local.bind(('', LOCAL_PORT))
sock_local.connect((LOCAL_SERVER_NAME, LOCAL_SERVER_PORT))

sockets = (sock_remote, sock_local)
for s in sockets:
    s.setblocking(0)

# loop forever forwarding packets between the connections
while True:
    avail, _, _ = select((sock_local, sock_remote), (), (), timeout=100)

    # send a keep alive message every timeout
    if not avail:
        sock_remote.send(b'keep alive')
        continue

    for s in avail:
        # something from the local server, forward it on
        if s is sock_local:
            msg = sock_local.recv(8192)
            sock_remote.send(msg)

        # something from the remote server
        if s is sock_remote:
            msg = sock_remote.recv(8192)
            # don't forward keep alives to local system
            if msg != b'keep alive':
                sock_local.send(msg)
