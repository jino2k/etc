import os
from os import listdir
from os.path import isfile, join
import pathlib
import shutil
from datetime import date, timedelta

MAX_BACKUP_DIRECTORIES = 10

cwd = os.getcwd()

today = date.today().strftime("%Y-%m-%d")
print("Today's date:", today)

########### backup confluence db #############################
current_dir = f"{today}/db_backup"
try:
    path = pathlib.Path(current_dir)
    path.mkdir(parents=True)

    cmd = f"pg_dump conf_db > {current_dir}/conf_db.sql"
    returned_value = os.system(cmd)  # returns the exit code in unix
    print('db backup returned value:', returned_value)

except OSError:
    print ("Creation of the directory %s failed" % current_dir)
else:
    print ("Successfully created the directory %s " % current_dir)

########### backup confluence home folder #############################
current_dir = f"{today}/confluence"
conf_home = "/var/atlassian/application-data/confluence"
cmd = f'''echo "sean" | sudo cp -ar {conf_home} {current_dir}'''
returned_value = os.system(cmd)  # returns the exit code in unix
print('confluence home copy returned value:', returned_value)

#########    Delete the oldest backup directories if the backup folder exceeds 10   ###########
onlybackupfolders = [f for f in listdir(".") if not isfile(f) and f[0:2] == "20"]
onlybackupfolders.sort()

print(f"length is {len(onlybackupfolders)}")
if len(onlybackupfolders) > MAX_BACKUP_DIRECTORIES:
    try:
        shutil.rmtree(onlybackupfolders[0])
    except OSError:
        print ("Deletion of the directory %s failed" % onlybackupfolders[0])
    else:
        print ("Successfully deleted the directory %s " % onlybackupfolders[0])
