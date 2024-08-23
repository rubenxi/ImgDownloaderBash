#!/bin/bash


lastuse=$(cat "./lastopen.txt")



lastweek="$(date +%Y-%m-%d -d "last week")"


lastusedate=$(date -d $lastuse +%s)
lastweekdate=$(date -d $lastweek +%s)

TOTAL=$(echo $lastusedate - $lastweekdate  | bc)
if [ "$TOTAL" -lt 0 ];
then
echo "$lastuse"
else
echo "$lastweek"
fi

