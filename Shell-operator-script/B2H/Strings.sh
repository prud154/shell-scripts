#!/bin/bash
#https://www.geeksforgeeks.org/string-manipulation-in-shell-scripting/
NAME='DevOps-Batch-B28'
echo $NAME       #Print String
echo ${#NAME}    #Print String Length
echo ${NAME:0:1} #D
echo ${NAME:0:2} #De
echo ${NAME:0:3} #Dev
echo ${NAME:0:4} #DevO

#Find the given STRING is palindrome.
#!/bin/bash
STRING_INPUT=$1      #TENET, SATORAREPOTENETOPERAROTAS
LEN=${#STRING_INPUT} #Value will be 5 which is 0,1,2,3,4
REVERSE=''
for ((i = $LEN - 1; i >= 0; i--)); do
    REVERSE="$REVERSE${STRING_INPUT:$i:1}"
    #echo $REVERSE
    #sleep 1
done
if [ "${STRING_INPUT}" == "${REVERSE}" ]; then
    echo "$STRING_INPUT is palindrome"
else
    echo "$STRING_INPUT is not palindrome"
fi
