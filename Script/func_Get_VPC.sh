#!/bin/bash
Get_VPC() {
    echo "Running The Functon To List VPCs in Region $1"
    vpc_list=$(aws ec2 describe-vpcs --region $1 | jq .Vpcs[].VpcId -r)
    for vpc in $(echo $vpc_list); do
        echo "The VPC ID IS:$vpc"
        echo "======================================="
    done
}

for REGION in $@; do
    Get_VPC $REGION
done
