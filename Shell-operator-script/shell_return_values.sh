#!/bin/bash
function testing1() {
    read -p "Enter the first number:" NUM1
    read -p "Enter the second number:" NUM2
    NEWNUM=$(($NUM1 + $NUM2))
    echo "The New Number is $NEWNUM"
    return ${NEWNUM}
}

function testing2() {
    read -p "Enter the first number:" NUM1
    read -p "Enter the second number:" NUM2
    NEWNUM=$(($NUM1 + $NUM2))
    echo "The New Number is $NEWNUM"
    return ${NEWNUM}
}

testing1
A=$?
testing2
B=$?
testing1
C=$?
testing2
D=$?
X=$(($A + $B + $C + $D))
echo $X
