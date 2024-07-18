https://www.geeksforgeeks.org/array-basics-shell-scripting-set-1/
#!/bin/bash
input=$1
reverse=''
len=${#input}
for ((i = $len - 1; i >= 0; i--)); do
    reverse="$reverse${input:$i:1}"
    echo $reverse
    sleep 1
done
if [ "${input}" == "${reverse}" ]; then
    echo "$input is ${reverse} so its palindrome"
else
    echo "$input is not ${reverse} so its not a palindrome"
fi

bash palindrome.sh SATORAREPOTENETOPERAROTAS

# step 1:- Take user input in a string
# step 2:- Findthe length of given string using length function
# step 3:- Set i = length-1 and run loop till i <= 0
# step 4:- echo the $i
# step 5:- repeat step 3 and 4 till i==0
# step 6:- end

#!/bin/bash
for STRING in $@; do
    len=${#STRING}
    for ((i = $len - 1; i >= 0; i--)); do
        NEW_LANG="$NEW_LANG${STRING:$i:1}"
    done
    if [ "${STRING}" = "${NEW_LANG}" ]; then
        echo "${STRING} is PALINDROME"
    else
        echo "${STRING} is NOT AT ALL PALINDROME"
    fi
    NEW_LANG=''
done

#!/bin/bash
while true; do
    read -p "Enter The Word:" STRING
    len=${#STRING}
    for ((i = $len - 1; i >= 0; i--)); do
        NEW_LANG="$NEW_LANG${STRING:$i:1}"
    done
    if [ "${STRING}" = "${NEW_LANG}" ]; then
        echo "${STRING} is PALINDROME"
    else
        echo "${STRING} is NOT AT ALL PALINDROME"
    fi
    NEW_LANG=''
done

