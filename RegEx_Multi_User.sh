#!/bin/bash
if [ $# -gt 0 ]; then
    for USERNAME in $@; do
        USER=$(echo $USERNAME | tr '[:upper:]' '[:lower:]')
        #if [[ $USER =~ ^[a-zA-Z]+$ ]]; then
        #if [[ $USER =~ ^[a-zA-Z] ]]; then
        if [[ "${USER}" =~ ^[a-zA-Z][a-zA-Z][a-zA-Z][0-9][0-9][0-9]$ ]]; then
            EXISTING_USER=$(cat /etc/passwd | grep -i -w $USER | cut -d ':' -f 1)
            if [ "${EXISTING_USER}" = "${USER}" ]; then
                echo "The Username $USER Provided already exists."
            else
                echo "Lets Create User $USER"
                sudo useradd -m $USER --shell /bin/bash
                sudo usermod -aG sudo $USER
                echo "$USER ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers
                SPEC=$(echo '!@#$%^&*()_' | fold -w1 | shuf | head -1)
                PASSWORD="India@${RANDOM}${SPEC}"
                echo "$USER:$PASSWORD" | sudo chpasswd
                passwd -e $USER
                echo "Please login with Username $USER and Password $PASSWORD"
            fi
        else
            echo "The Username Must Container Only Alphabets"
        fi
    done
else
    echo "Please Provide Valid Input."
fi
