#!/bin/bash
if [ $# -gt 0 ]; then
    for PROCESSORPORT in $@; do
        netstat -nltp | grep -i $PROCESSORPORT >/dev/null
        if [ $? -eq 0 ]; then
            netstat -nltp | grep -i $PROCESSORPORT | awk '{print $7, $4}' | tr -d ':'
            echo "Process or Port $PROCESSORPORT Is Listening..."
        else
            echo "The Process Or Port $PROCESSORPORT You Are Checking Is Not Listening or Dont Exist....!!"
        fi
    done
else
    echo "You Have Provided $# Arguments. Please Enter Valid Processname Or Port Number."
fi
