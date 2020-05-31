WORKSPACE="."
FILE="${WORKSPACE}/updatedate.txt"
CURRENTEPOCTIME=$((`date +"%s"`/86400))

echo "current time $CURRENTEPOCTIME"

backupsql()
{
  sshpass -p "sean" ssh -tt jino@192.168.0.14 '
    echo "Hello I am a function"
    cd /media/ssd
    ls
  '  
}


if test -f "$FILE"; then
  BACKUPTIME=$(cat $FILE)
  echo "Backup time is $BACKUPTIME"
  DIFF=$(($CURRENTEPOCTIME - $BACKUPTIME))
  echo "Date difference is $DIFF"

  if [ $DIFF -gt 6 ]; then
    backupsql
  else
    echo "Let's Skip today"
  fi

else
  echo $CURRENTEPOCTIME > $FILE
  echo "file is created"
  cat $FILE
  backupsql
fi
