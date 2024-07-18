#Create file as servers.txt and place all your servers ip in lines
8.8.8.8
76.76.19.19
8.8.4.4
76.223.122.150
1.1.1.1
94.140.15.15
185.228.168.9
185.228.169.9

#!/bin/bash
rm -f error.log
PORTS=(80 443 53 22 3389)
servers=$(cat servers.txt)
for server in ${servers[@]}; do
    for PORT in ${PORTS[@]}; do
        nc -w 1 $server $PORT
        if [ $? -eq 0 ]; then
            echo "$server is Rechable on $PORT"
        else
            echo "$server is NOT-RECHABLE on $PORT" >>error.log
            continue
        fi
    done
done
