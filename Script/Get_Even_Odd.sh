#Script to find EVEN and ODD Numbers
#!/bin/bash
for I in {1..5}; do
    read -p "Please Enter A Valid Number:" NUM
    echo $NUM
    if [ $(expr $NUM % 2) -eq 0 ]; then
        echo "$NUM is an EVEN Number"
    else
        echo "$NUM is an ODD Number"
    fi
done
