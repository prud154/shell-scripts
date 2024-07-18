#!/bin/bash
for REGION in $(aws ec2 describe-regions | jq ".Regions[].RegionName" | tr -d '"'); do
    echo "Getting EC2 Instacnce Information For Region $REGION"
    VM=$(aws ec2 describe-instances --region $REGION | jq ".Reservations[].Instances[].InstanceId" | tr -d '"' | wc -l)
    if [ $VM -gt 0 ]; then
        echo "The region $REGION has $VM EC2 Instances. The instance IDs are:"
        aws ec2 describe-instances --region $REGION | jq ".Reservations[].Instances[].InstanceId" | tr -d '"'
        echo "--------------------------------------------------------------------"
    else
        echo "The region $REGION has $VM EC2 Instances."
        echo "--------------------------------------------------------------------"
    fi
done