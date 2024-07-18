#!/bin/bash
STRING=$1
STRING_LEN=$(expr ${#STRING} - 1)
STRING_REV=''
echo $STRING_LEN
for ((i = $STRING_LEN; i >= 0; i--)); do
    X=${STRING[@]:$i:1}
    STRING_REV=${STRING_REV}$X
done
if [ ${STRING} = ${STRING_REV} ]; then
    echo "${STRING} is a PLAINDROME"
else
    echo "${STRING} is a NON-PLAINDROME"
fi
