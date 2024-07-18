#!/bin/bash
set +x
#Declaring A List/Array
SERVERS=('10.1.1.100' '10.39.1.186' '172.16.1.100' '10.39.1.186' '192.168.1.100' '10.39.1.186')
echo ${SERVERS[@]}
rm -rf /tmp/servers
for SERVER in ${SERVERS[@]}; do
    echo "Testing Connectivity For $SERVER"
    #netcat -z -n -v -w3 $SERVER 22 2>&1 | grep succeeded | tee -a /tmp/servers
    netcat -z -n -v -w3 $SERVER 22 2>&1
    if [ $? -eq 0 ]; then
        echo "$SERVER Is Reachable On TCP 22."
    else
        echo "$SERVER Failed To Reach On TCP 22."
    fi
    echo "#######################################"
done
