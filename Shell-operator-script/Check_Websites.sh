#!/bin/bash
aws_regions=(cat websites.txt)
for url in ${aws_regions[@]}; do
    curl -sLk $url
    if [ $? -eq 0 ]; then
        echo "$url is working"
    else
        echo "Breaking at $url"
        break
    fi
done

#!/bin/bash
aws_regions=(cat servers.txt)
for server in ${aws_regions[@]}; do
    nc -w 1 $server 53
    if [ $? -eq 0 ]; then
        echo "$server is Rechable"
    else
        echo "Breaking at $url"
        break
    fi
done

#!/bin/bash
rm -f error.log
PORTS=(80 443 53 22 3389)
aws_regions=$(cat servers.txt)
for server in ${aws_regions[@]}; do
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
