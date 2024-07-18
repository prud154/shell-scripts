#!/bin/bash
allvpc='aws ec2 describe-vpcs  | jq ".Vpcs[].VpcId"'
if [ $? -eq 0 ]; then
    echo "Command Was Sucessfull..."
    echo $allvpc
else
    echo "Command failed with error code $?"
fi


#!/bin/bash
if [ $# -gt 0 ]; then
    aws ec2 describe-vpcs --region $1 | jq ".Vpcs[].VpcId"
    echo "-----------------------------------------"
    aws ec2 describe-vpcs --region $2 | jq ".Vpcs[].VpcId"
    echo "-----------------------------------------"
    aws ec2 describe-vpcs --region $3 | jq ".Vpcs[].VpcId"
    echo "You have requested VPC information for $# regions"
else
    echo "You Have Given $# params, please give more then one."
fi

$@ = us-east-1 ys-east-2 us-west-1 us-west-2
#!/bin/bash
for REGION in $@
do
aws ec2 describe-vpcs --region $REGION | jq ".Vpcs[].VpcId"
echo "-----------------------"
done
echo "You Have Given $# regions"

