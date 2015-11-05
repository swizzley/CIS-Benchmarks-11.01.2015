#!/bin/bash

#Backup files and dirs
/bin/tar -cvf /root/backup.`/bin/date +%Y%m%d%H%M`.tar `/bin/cat \ /tmp/filelist`
#Create restore script
if [ -e /root/do-restore.sh ]; then
  echo "/root/do-restore.sh exists, exiting"
  exit 1
else
  echo '#!/bin/bash' >>/root/do-restore.sh
  /bin/chmod 700 /root/do-restore.sh
  echo 'cd /' >>/root/do-restore.sh
  echo '/bin/tar -Uxvf `/bin/ls -A1rt /root/backup.*.tar | tail -1`' \     
  >>/root/do-restore.sh
  /usr/bin/find /var/log -printf "chmod %m %h/%f\n" \ 
  >>/root/do-restore.sh
fi
echo Backup complete. 

