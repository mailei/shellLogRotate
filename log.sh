#!/bin/sh
DATE=`date +%Y%m%d -d '1 day ago'`

applog="app.log"
errorlog="error.log"
logfiles="${applog} ${errorlog}"

# read conf file(log dir)
LOGDIR=`cat conf`

# test write log
echo "test" >> ./log/${applog}

for logFile in $logfiles
do
  for file in $logFile
  do
    cp ${LOGDIR}/${file} ${LOGDIR}/${file}.$DATE
    if [ $? = 0 ];then
      # prune log file
      cp /dev/null ${LOGDIR}/${file}
    fi
    # delete log file before 14 days
    find ${LOGDIR}/${file}.* -mtime +13 | xargs --no-run-if-empty /bin/rm
  done
done
exit 0