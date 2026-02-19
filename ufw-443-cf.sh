#!/bin/bash

curl https://www.cloudflare.com/ips-v4/# -o cf-v4
curl https://www.cloudflare.com/ips-v6/# -o cf-v6

#less cf-v4
#less cf-v6

for ip in $(cat cf-v4); 
do 
    sudo ufw allow from $ip to any port 443; 
done

for ip in $(cat cf-v6); 
do 
    sudo ufw allow from $ip to any port 443; 
done
