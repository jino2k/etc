WORKSPACE="."
FILE="${WORKSPACE}/updatedate.txt"
CURRENTEPOCTIME=$((`date +"%s"`/86400))
TODAY=`date +"%y-%m-%d"`

echo "current time $CURRENTEPOCTIME"
echo "today is $TODAY"

backupsql()
{
  ls
  # sshpass -p "sean" ssh -tt jino@192.168.0.14 '
  #   cd /media/ssd/conf_backup/prodbackup
  #   ./runbackup.sh
  # '  
}

copy_backup_to_local()
{
  sshpass -p "sean" scp -r "jino@192.168.0.14:/media/ssd/conf_backup/prodbackup/$TODAY" "/media/jino/New Volume/conf_backup/"
}


if test -f "$FILE"; then
  BACKUPTIME=$(cat $FILE)
  echo "Last backup time is $BACKUPTIME"
  DIFF=$(($CURRENTEPOCTIME - $BACKUPTIME))
  echo "Date difference is $DIFF"

  if [ $DIFF -gt 6 ]; then
    backupsql
    copy_backup_to_local
  else
    echo "Let's Skip today"
  fi

else
  echo $CURRENTEPOCTIME > $FILE
  echo "Timestamp file has been created"
  cat $FILE
  backupsql
  copy_backup_to_local
fi
