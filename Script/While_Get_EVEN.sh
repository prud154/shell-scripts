#!/bin/bash
I=0
while [ $I -le 5 ]; do
    read -p "Please Enter A Valid Number:" NUM
    echo $NUM
    if [ $(expr $NUM % 2) -eq 0 ]; then
        echo "$NUM is an EVEN Number"
    else
        echo "$NUM is an ODD Number"
    fi
    I=$(($I + 1))
done
