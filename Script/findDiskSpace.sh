#https://www.linode.com/docs/guides/solving-real-world-problems-with-bash-scripts-a-tutorial/
#!/bin/bash
#set -x
# default value to use if none specified
PERCENT=50
SLACK_WEB='https://hooks.slack.com/services/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'

# test for command line arguement is present
if [[ $# -le 0 ]]; then
    echo "Using default value of ${PERCENT} for threshold.\n"
# test if argument is an integer
# if it is, use that as percent, if not use default
else
    if [[ $1 =~ ^-?[0-9]+([0-9]+)?$ ]]; then
        PERCENT=$1
    else
        echo "INVALID INPUT"
        exit 1
    fi
fi

#let "PERCENT += 0"
#printf "Threshold = %d\n" $PERCENT
echo "Threshold = $PERCENT"
df -Ph | grep -i root | awk '{ print $5,$1 }' | while read data; do
    usedspace=$(echo $data | awk '{print $1}' | sed s/%//g)
    partition=$(echo $data | awk '{print $2}')
    if [ $usedspace -ge $PERCENT ]; then
        echo "WARNING: The partition \"$partition\" has used $usedspace% of total available space and above Threshold  of $PERCENT  - Date: $(date)"
        curl -X POST ${SLACK_WEB} -sL -H 'Content-type: application/json' --data "{"text": \"Current Utilization of root volume is: ${usedspace}\"}" >>/dev/null
    else
        echo "Your Disk Space of \"$partition\" is well below the Threshold  of $PERCENT and current utilization is $usedspace% ."
    fi
done
