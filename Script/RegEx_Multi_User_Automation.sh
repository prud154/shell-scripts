#!/bin/bash
SLACK_WEB='https://hooks.slack.com/services/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'
if [ $# -gt 0 ]; then
    for USERNAME in $@; do
        #if [[ $USERNAME =~ ^[a-zA-Z]+$ ]]; then
        #if [[ $USERNAME =~ ^[a-z][a-z][a-z][0-9][0-9][0-9]$ ]]; then
        if [[ $USERNAME =~ [a-z]{3}[0-5]{3} ]]; then
            EXISTING_USER=$(cat /etc/passwd | grep -i -w ${USERNAME} | cut -d ':' -f 1)
            if [ "${USERNAME}" = "${EXISTING_USER}" ]; then
                echo "The User "${USERNAME}" Already Exists."
            else
                echo "Lets Create The user "${USERNAME}"."
                sudo useradd -m ${USERNAME} --shell /bin/bash
                sudo usermod -aG sudo ${USERNAME}
                echo '${USERNAME} ALL=(ALL) NOPASSWD: ALL' >>/etc/sudoers
                SPEC=$(echo '!@#$%^&*()_' | fold -w1 | shuf | head -1)
                PASSWORD="India@${RANDOM}${SPEC}"
                echo "${USERNAME}:${PASSWORD}" | sudo chpasswd
                passwd -e ${USERNAME} >>/dev/null
                #echo "The Temporary Credentails are ${USERNAME} and ${PASSWORD}"
                curl -X POST ${SLACK_WEB} -sL -H 'Content-type: application/json' --data "{"text": \"The Username Is:\"}" >>/dev/null
                curl -X POST ${SLACK_WEB} -sL -H 'Content-type: application/json' --data "{"text": \"${USERNAME}\"}" >>/dev/null
                curl -X POST ${SLACK_WEB} -sL -H 'Content-type: application/json' --data "{"text": \"The Password Is:\"}" >>/dev/null
                curl -X POST ${SLACK_WEB} -sL -H 'Content-type: application/json' --data "{"text": \"${PASSWORD}\"}" >>/dev/null
            fi
        else
            echo "The Username Must Container Only ALPHABETS"
        fi
    done
else
    echo "Provide Valid Argument."
fi
