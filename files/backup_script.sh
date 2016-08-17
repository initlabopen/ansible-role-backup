#!/bin/bash
#
# $1 - source path
# $2 - destination path
# $3 - user database
# $4 - password for user database
# $5 - name database
# $6 -
#
date=$(date +%Y%m%d)
BACKUP_DIR=$2/${date}
mkdir $BACKUP_DIR
cd $BACKUP_DIR
rsync -av $1/ $BACKUP_DIR/ > /dev/null
nice -n 19 mysqldump -u$3 -p$4 --lock-tables=false --default-character-set=utf8 $5 > $5_${date}.sql
nice -n 19 tar cvzf ../backup_${date}.tar.gz . > /dev/null
chmod -R 777 $BACKUP_DIR
rm -rf $BACKUP_DIR
find $2 -type f -mtime +$6 -delete
