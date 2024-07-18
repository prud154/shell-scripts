#!/bin/bash
#https://www.geeksforgeeks.org/array-basics-shell-scripting-set-1/
AWS_REGIONS=(us-east-1 us-east-2 us-west-1 us-west-2 ap-south-1)
echo $AWS_REGIONS #Incorrect Way
[@] &
[*] means All elements of Array.
echo ${AWS_REGIONS[@]}   # Prints items in the array
echo ${AWS_REGIONS[*]}   # Prints items in the array
echo ${AWS_REGIONS[*]:0} # Prints items in the array
echo ${AWS_REGIONS[@]:0} # Prints items in the array

echo ${#AWS_REGIONS[@]} # # Prints item count

echo ${AWS_REGIONS[0]} #us-east-1
echo ${AWS_REGIONS[1]} #us-east-2
echo ${AWS_REGIONS[2]} #us-west-1
echo ${AWS_REGIONS[3]} #us-west-2
for REGION in ${AWS_REGIONS[@]}; do
    echo " Lets Get VPC ID for $REGION"
    vpc_list=$(aws ec2 describe-vpcs --region $REGION | jq ".Vpcs[].VpcId" | tr -d '"')
    vpc_array=($vpc_list)
    echo ${vpc_array[@]}
    sleep 1
done

AWS_REGIONS=(us-east-1 us-east-2 us-west-1 us-west-2 ap-south-1)
#To print elements from a particular index
echo ${ARRAYNAME[WHICH_ELEMENT]:STARTING_INDEX}
echo ${AWS_REGIONS[@]:0} #us-east-1 us-east-2 us-west-1 us-west-2 ap-south-1
echo ${AWS_REGIONS[@]:1} #us-east-2 us-west-1 us-west-2 ap-south-1
echo ${AWS_REGIONS[@]:2} #us-west-1 us-west-2 ap-south-1
echo ${AWS_REGIONS[@]:3} #us-west-2 ap-south-1
echo ${AWS_REGIONS[@]:4} #ap-south-1

AWS_REGIONS=(us-east-1 us-east-2 us-west-1 us-west-2 ap-south-1)
#                0         1          2       3           4
#To print elements in range
echo ${ARRAYNAME[WHICH_ELEMENT]:STARTING_INDEX:COUNT_ELEMENT}
echo ${AWS_REGIONS[@]:0:1} #us-east-1
echo ${AWS_REGIONS[@]:1:1} #us-east-2
echo ${AWS_REGIONS[@]:2:1} #us-west-1
echo ${AWS_REGIONS[@]:3:1} #us-west-2
echo ${AWS_REGIONS[@]:4:1} #ap-south-1
