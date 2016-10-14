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
find $2 -type f -mtime +0 -delete
cd $2
if [ -z $5 ]
then
nice -n 19 mysqldump -u$3 -p$4 --lock-tables=false --default-character-set=utf8 $5 | gzip > $2/$5_${date}.sql.gz
fi
nice -n 19 tar cvzf $2/backup_${date}.tar.gz -X 'exclude.txt' $1 > /dev/null
