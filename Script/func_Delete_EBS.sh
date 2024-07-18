#!/bin/bash
VALID_REGIONS=$(aws ec2 describe-regions | jq ".Regions[].RegionName" -r)
check_vols() {
    COUNT=$(aws ec2 describe-volumes --region $1 | jq ".Volumes[]")
    if [ ${#COUNT} -gt 0 ]; then
        unttached_ebs $REGION
    else
        cowsay "The REGION $1 dont have any volumes attached or detached."
    fi
}

unttached_ebs() {
    for VOL in $(aws ec2 describe-volumes --region $1 | jq ".Volumes[].VolumeId" | tr -d '"'); do
        STATE=$(aws ec2 describe-volumes --volume-ids $VOL --region $1 | jq ".Volumes[].State" -r)
        # if [ "${STATE}" = 'in-use' ]; then

        #     echo "$VOL is attached and cannot be deleted."
        #     echo '-----------------------------------------'
        # else
        #     echo "Lets Delete VOlume $VOL"
        #     aws ec2 delete-volume --volume-id $VOL
        #     echo '-----------------------------------------'
        # fi
        if [ "${STATE}" != 'in-use' ]; then
            cowsay "$VOL is not attached and can be deleted."
            aws ec2 delete-volume --volume-id $VOL --region $1
            echo '-----------------------------------------'
        else
            cowsay "The $VOL in region $1 is attached and cannot be deleted."
        fi
    done
}
echo $VALID_REGIONS
for REGION in ${VALID_REGIONS[@]}; do
    check_vols $REGION
done
