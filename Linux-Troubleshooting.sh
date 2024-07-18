https://phoenixnap.com/kb/ulimit-linux-command
ulimit is a built-in Linux shell command that allows viewing or limiting system resource amounts that individual users consume.
Limiting resource usage is valuable in environments with multiple users and system performance issues.
ulimit -Sa #Soft Limits
ulimit -Ha #Hard Limits

ulimit -f 1024 #Limit file size in blocks.
wget https://releases.hashicorp.com/terraform/1.4.5/terraform_1.4.5_linux_amd64.zip
File size limit exceeded (core dumped)

ulimit -u 100 ubuntu

To Set limits permanently we need to edit /etc/security/limits.conf.
ubuntu  hard    fsize   1024
ubuntu  hard    maxlogins   1
ubuntu  hard    nproc   15

for I in {1..15}
do
sleep 200 &
done

https://medium.com/tensult/troubleshooting-applications-in-linux-bbc62aca0282
https://medium.com/geekculture/linux-troubleshoot-100-cpu-usage-64278c9c298

LSOF:
https://www.thegeekstuff.com/2012/08/lsof-command-examples/

lsof
grep
ps -ef
awk
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head



