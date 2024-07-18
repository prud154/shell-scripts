#!/bin/bash
REGION=$1
echo $0
echo $1
aws ec2 describe-vpcs --region $1 | jq ".Vpcs[].VpcId" -r

REGION=$*
for REGION in $*; do
    cowsay "Lets Get VPC Details For Region $REGION"
    aws ec2 describe-vpcs --region $REGION | jq ".Vpcs[].VpcId" -r
    echo "-----------------------------"
done
cowsay "Lets Have Provided $# Arguments To This Script."

#!/bin/bash
if [ $# -gt 0 ]; then
    for REGION in $*; do
        cowsay "Lets Get VPC Details For Region $REGION"
        aws ec2 describe-vpcs --region $REGION | jq ".Vpcs[].VpcId" -r
        echo "-----------------------------"
    done
else
    cowsay "Lets Have Provided $# Arguments To This Script."
fi
