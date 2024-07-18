#!/bin/bash
for REGION in $(aws ec2 describe-regions | jq ".Regions[].RegionName" | tr -d '"'); do
    echo "Getting AZ Zone Information For Region $REGION"
    ZONES=$(aws ec2 describe-availability-zones --region $REGION | jq ".AvailabilityZones[].ZoneName" | tr -d '"' | wc -l)
    if [ $ZONES -lt 3 ]; then
        echo "The region $REGION has $ZONES Availibility Zone. The Zone Names are:"
        aws ec2 describe-availability-zones --region $REGION | jq ".AvailabilityZones[].ZoneName" | tr -d '"'
        echo "This Region $REGION Falls Under Very Small Infrastructure"
        echo "------------------------------------------------------------------------------"
    elif [ $ZONES -lt 4 -a $ZONES -gt 2 ]; then
        echo "The region $REGION has $ZONES Availibility Zone. The Zone Names are:"
        aws ec2 describe-availability-zones --region $REGION | jq ".AvailabilityZones[].ZoneName" | tr -d '"'
        echo "This Region $REGION Falls Under Small Infrastructure"
        echo "------------------------------------------------------------------------------"
    elif [ $ZONES -lt 5 -a $ZONES -gt 3 ]; then
        echo "The region $REGION has $ZONES Availibility Zone. The Zone Names are:"
        aws ec2 describe-availability-zones --region $REGION | jq ".AvailabilityZones[].ZoneName" | tr -d '"'
        echo "This Region $REGION Falls Under Medium Infrastructure"
        echo "------------------------------------------------------------------------------"
    else
        echo "The region $REGION has $ZONES Availibility Zone. The Zone Names are:"
        aws ec2 describe-availability-zones --region $REGION | jq ".AvailabilityZones[].ZoneName" | tr -d '"'
        echo "This Region $REGION Falls Under Big Infrastructure"
        echo "------------------------------------------------------------------------------"
    fi
done