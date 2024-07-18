#!/bin/bash
read -p "Enter The NUM1:" NUM1
read -p "Enter The NUM2:" NUM2
echo $NUM1
echo $NUM2
if [ $NUM1 == $NUM2 ]; then
    echo "BOTH ARE EQUAL"
else
    echo "BOTH ARE NOT-EQUAL"
fi

for I in {1..100}; do
    if [ $(expr $I % 2) == 0 ]; then
        echo "$I is an EVEN Number"
    fi
done

for I in {1..100}; do
    if [ $(expr $I % 2) -eq 0 ]; then
        echo "$I is an EVEN Number"
    fi
done

for I in {1..100}; do
    if [ $(expr $I % 2) != 0 ]; then
        echo "$I is an ODD Number"
    fi
done

for I in {1..100}; do
    if [ $(expr $I % 2) -ne 0 ]; then
        echo "$I is an ODD Number"
    fi
done

for I in {1..100}; do
    if [ $(expr $I % 2) -ne 0 ]; then
        echo "$I is an ODD Number"
        echo "-----------------------"
    else
        echo "$I is an EVEN Number"
        echo "-----------------------"
    fi
done

BUCKET_COUNT=$(aws s3 ls | cut -d " " -f3 | wc -l)
MAX_BUCKET=50
CURRENT_USAGE=$(expr $MAX_BUCKET - $BUCKET_COUNT)
if [ $BUCKET_COUNT -lt 50 ]; then
    echo "You Quota Is Going To Finish Soon. You have $CURRENT_USAGE left"
fi

#!/bin/bash
VPC_COUNT=$(aws ec2 describe-vpcs | jq ".Vpcs[].VpcId" | tr -d '"' | wc -l)
MAX_VPC=20
CURRENT_USAGE=$(expr $MAX_VPC - $VPC_COUNT)
if [[ $VPC_COUNT < 20 ]]; then
    echo "You Quota Is Going To Finish Soon. You have $CURRENT_USAGE VPC left"
else
    echo "LIMIT EXCEEDED."
fi

#!/bin/bash
VPC_COUNT=$(aws ec2 describe-vpcs | jq ".Vpcs[].VpcId" | tr -d '"' | wc -l)
echo $VPC_COUNT
MAX_VPC=20
CURRENT_USAGE=$(expr $MAX_VPC - $VPC_COUNT)
if [ $VPC_COUNT -lt 6 -a $VPC_COUNT -gt 0 ]; then
    echo "You Have Consumed 25% of Your VPC Quota...."
elif [ $VPC_COUNT -lt 11 -a $VPC_COUNT -gt 5 ]; then
    echo "You Have Consumed 50% of Your VPC Quota...."
elif [ $VPC_COUNT -lt 15 -a $VPC_COUNT -gt 10 ]; then
    echo "You Have Consumed 75% of Your VPC Quota...."
else
    echo "You are about to reach the limit"
fi

aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-0f47002cff9d8dd21" | jq ".Subnets[].SubnetId"

#!/bin/bash
aws ec2 describe-vpcs | jq ".Vpcs[].VpcId" | tr -d '"'
read -p "Please Provide The VPC ID from the above:" VPC_ID
if [ -z $VPC_ID ]; then
    echo "Please Give A Valid Input From The VPC List Above"
else
    aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" | jq ".Subnets[].SubnetId"
fi

#!/bin/bash
aws ec2 describe-vpcs | jq ".Vpcs[].VpcId" | tr -d '"'
read -p "Please Provide The VPC ID from the above:" VPC_ID
if [ -n $VPC_ID ]; then    
    aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" | jq ".Subnets[].SubnetId"
else
    echo "Please Give A Valid Input From The VPC List Above"
fi

#!/bin/bash
aws ec2 describe-vpcs | jq ".Vpcs[].VpcId" | tr -d '"'
read -p "Please Provide The VPC ID from the above:" VPC_ID
if [ "$VPC_ID" = '' ]; then
    echo "Please Give A Valid Input From The VPC List Above"
else
    aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" | jq ".Subnets[].SubnetId"
fi

#!/bin/bash
aws ec2 describe-vpcs | jq ".Vpcs[].VpcId" | tr -d '"'
read -p "Please Provide The VPC ID from the above:" VPC_ID
if [ ! $VPC_ID = '' ]; then
    aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" | jq ".Subnets[].SubnetId"
else
    echo "Please Give A Valid Input From The VPC List Above"
fi


if [  "$VPC_ID" = '' ]; then
    echo "Please Give A Valid Input From The VPC List Above"
else
   aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" | jq ".Subnets[].SubnetId"
fi


