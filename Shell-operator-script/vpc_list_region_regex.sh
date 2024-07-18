ALL_REGIONS=$(aws ec2 describe-regions | jq ".Regions[].RegionName" | tr -d '"')
MY_REGIONS=(us-east-1 us-east-2 us-west-1 us-west-2 ind-hyd-1)
REGIONS=$@
if [ $# -gt 0 ]; then
    for REGION in $REGIONS; do
        if [[ $ALL_REGIONS =~ (^|[[:space:]])"$REGION"($|[[:space:]]) ]]; then
            echo "Getting Details For Region $REGION"
            echo "Executing In The Main IF Statement"
            aws ec2 describe-vpcs --region $REGION | jq '.Vpcs[]|.VpcId,.CidrBlock' | paste - - | tr -d '"' | awk '{print $1 "->>" $2}'
            INST_COUNT=$(aws ec2 describe-instances --region $REGION | jq ".Reservations[].Instances[].InstanceId" | tr -d '"' | wc -l)
            if [ $INST_COUNT -gt 0 ]; then
                aws ec2 describe-instances --region $REGION | jq ".Reservations[].Instances[].InstanceId" | tr -d '"'
            else
                echo "NO EC2 INSTANCES FOUND IN REGION $REGION"
            fi
            echo "*************************************"
        elif [[ ${MY_REGIONS[*]} =~ (^|[[:space:]])"$REGION"($|[[:space:]]) ]]; then
            echo "Getting Details For Region $REGION"
            echo "Executing In The ELIF Statement"
            INST_COUNT=$(aws ec2 describe-instances --region $REGION | jq ".Reservations[].Instances[].InstanceId" | tr -d '"' | wc -l)
            if [ $INST_COUNT -gt 0 ]; then
                aws ec2 describe-instances --region $REGION | jq ".Reservations[].Instances[].InstanceId" | tr -d '"'
            else
                echo "NO EC2 INSTANCES FOUND IN REGION $REGION"
            fi
            echo "*************************************"
        else
            echo "Executing In The FINAL ELSE Statement"
            echo "$REGION IS AN INVALID REGION"
        fi
    done

else
    echo "INVALID INPUT or NO INPUT GIVEN"
fi
echo "You Have Provided $# parameters"
