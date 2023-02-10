# -*- coding: utf-8 -*-

import requests
import threading

email = input('email: ')
api_key = input('api key: ')
headers = {'X-Auth-Email': email, 'X-Auth-Key': api_key}


def get_zone_id(domain):
    gz = requests.get('https://api.cloudflare.com/client/v4/zones?name='+ domain, headers=headers).json()
    return gz['result'][0]['id']


domain = input('domain: ')
zone_id = get_zone_id(domain)
dns_url = 'https://api.cloudflare.com/client/v4/zones/' + zone_id + '/dns_records/'


def delete(_id):
    delete_id = requests.delete(dns_url + _id, headers=headers)
    print(delete_id.text)


request = requests.get(dns_url, headers=headers).json()
for record in request['result']:
    _id = record['id']
    threading.Thread(target=delete, args=(_id, )).start()
