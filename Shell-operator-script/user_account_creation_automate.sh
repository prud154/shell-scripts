#!/bin/bash
for USERNAME in $@; do
    if [[ -z $USERNAME || "${USERNAME}" =~ [[:digit:]] ]]; then
        echo "$USERNAME IS INVALID. USERNAME MUST NOT BE EMPTY OR CONTAIN ANY DIGITS"
    else
        EXUSER=$(cat /etc/passwd | grep -i -w $USERNAME | cut -d ':' -f 1)
        if [ "${USERNAME}" = "${EXUSER}" ]; then
            echo "$USERNAME already exists....!!!"
        else
            SPEC=$(echo '!@#$%^&*()_' | fold -w1 | shuf | head -1)
            PASSWORD=India@${RANDOM}${SPEC}
            echo "Lets Create User $USERNAME"
            useradd -m $USERNAME
            echo "${USERNAME}:${PASSWORD}" | sudo chpasswd
            passwd -e ${USERNAME}
            echo "Username is ${USERNAME}  Password is ${PASSWORD}"
        fi
    fi
done
