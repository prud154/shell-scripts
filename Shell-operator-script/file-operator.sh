#!/bin/bash
apt update && apt install -y unzip 
echo "Availible Terraform Versions..."
echo "14.0 to 14.11"
echo "15.0 to 15.3"
read -p "Enter The Terraform MAJOR Version:" MAJOR #14
read -p "Enter The Terraform MINOR Version:" MINOR #9
#MAJOR=14
#MINOR=10
folder1=${MAJOR}-${MINOR}
if [ $MAJOR -lt 14 ]; then
    echo "Please Select Either of 14 or 15 version"
else
    VERSION=${MAJOR}.${MINOR}
    echo "Downloading Terarform Version 0.${VERSION}"
    if [ -d /tmp/$folder1 ]; then
        echo "FODLER EXISTS"
        cd /tmp/$folder1
        if [ -f terraform_${VERSION}.zip ]; then
            echo "Version Already Exists...."
            rm -f terraform
            unzip -o terraform_${VERSION}.zip
            chmod 777 terraform
            ./terraform version
        else
            wget https://releases.hashicorp.com/terraform/0.${VERSION}/terraform_0.${VERSION}_linux_amd64.zip
            mv -f terraform_0.${VERSION}_linux_amd64.zip terraform_${VERSION}.zip
            unzip -o terraform_${VERSION}.zip
            chmod 777 terraform
            ./terraform version
        fi        
    else
        echo "Lets Create The Folder"
        mkdir /tmp/$folder1 && cd /tmp/$folder1
        wget https://releases.hashicorp.com/terraform/0.${VERSION}/terraform_0.${VERSION}_linux_amd64.zip
        mv terraform_0.${VERSION}_linux_amd64.zip terraform_${VERSION}.zip
        unzip terraform_${VERSION}.zip
        chmod 777 terraform
        ./terraform version
    fi
fi
