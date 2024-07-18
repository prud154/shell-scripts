cat /etc/passwd >/tmp/testfile       #Overwrites
cat /etc/passwd >>/tmp/testfile      #Appends
ls -al | tee /tmp/testfile1          #Prints & Writes To Files
echo "hello" | tee -a /tmp/testfile1 #Prints & Appends To Files

STDIN - 0
STDOUT - 1
STDERR - 2

#!/bin/bash
echo "One"
megastar
echo "Two"
superstar
echo "Three"
burningstar

bash stars.sh 1>/dev/null
bash stars.sh 2>/dev/null
bash stars.sh >/dev/null 2>&1
