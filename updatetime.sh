FILE="${WORKSPACE}/updatedate.txt"
CURRENTEPOCTIME=$((`date +"%s"`/86400))

echo "current time $CURRENTEPOCTIME"

if test -f "$FILE"; then
  BACKUPTIME=$(cat $FILE)
  echo "Backup time is $BACKUPTIME"
  echo "Date difference is $(($CURRENTEPOCTIME - $BACKUPTIME))"
else
  echo $CURRENTEPOCTIME > $FILE
  echo "file is created"
  cat $FILE
fi
