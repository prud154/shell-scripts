#Checking String Operators
#!/bin/bash
A=''
if [ -z $A ]; then
    echo "VALUE NOT DECLARED"
else
    echo "The VALUE OF A is $A"
fi

if [ -n $A ]; then
    echo "The VALUE OF A is $A"
else
    echo "VALUE NOT DECLARED"
fi

#Checking File Operators
#!/bin/bash
if [ -f /etc/passwd ]; then
    echo "FILE EXIST"
else
    echo "Lets Create a FILE"
fi
