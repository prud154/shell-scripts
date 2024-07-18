#!/bin/bash
$1 >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "The COMMAND WAS SUCCESSFULL"
else
    echo "THE COMMAND FAILED"
fi

#!/bin/bash
export SYSTEMD_PAGER=
service nginx status >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "The Application Nginx Is Already Running...!!"
else
    echo "NGinx is not running. Lets restart it...."
    service nginx start
fi
