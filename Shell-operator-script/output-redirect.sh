apt update >/tmp/update.log
apt update >>/tmp/update.log
apt update | tee /tmp/tee.log
apt update | tee -a /tmp/tee.log

Discarding Output:
apt update >/dev/null
apt update >>/dev/null
apt update | tee /dev/null
apt update | tee -a /dev/null

Redirecting stdout and stderr:
#!/bin/bash
apt update
youngtiger
free
megastar
df
superstar
echo "Hello"
burningstar

bash stdtesting - Redirect stdout to /dev/null 1>/dev/null
bash stdtesting - Redirect stderr to /dev/null 2>/dev/null
bash stdtesting - Redirect stderr >/dev/null 2>&1 &
stdout to /dev/null
