#!/bin/sh
DATE=`date +%Y%m%d -d '1 day ago'`

LOGFILES="$1 $2"

# read conf file(log dir)
LOGDIR=`cat conf`

# test write log
echo "test" >> ./log/$1
echo "test" >> ./log/$2

for logFile in $LOGFILES
do
  for file in $logFile
  do
    if [ -f ${LOGDIR}/${file}.${DATE} ];then
    break 
    fi
    cp ${LOGDIR}/${file} ${LOGDIR}/${file}.$DATE
    if [ $? = 0 ];then
      # prune log file
      cp /dev/null ${LOGDIR}/${file}
    fi
    # delete log file before 14 days
    find ${LOGDIR}/${file}.* -mtime +13 | xargs --no-run-if-empty rm
  done
done
exit 0
