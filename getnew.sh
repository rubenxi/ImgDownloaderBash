#!/bin/bash

mkdir ~/ImgDownloaderBash/today > /dev/null 2>&1
mkdir ~/ImgDownloaderBash/yesterday > /dev/null 2>&1

rm ~/ImgDownloaderBash/yesterday/* > /dev/null 2>&1
rm ~/ImgDownloaderBash/today/* > /dev/null 2>&1

for entry in ~/ImgDownloaderBash/*
do
  
if [[ -f "$entry" ]]
then

string=$(stat -c '%y' "$(realpath "$entry")" | cut -d' ' -f1-1)
stringaccess=$(stat -c '%x' "$(realpath "$entry")" | cut -d' ' -f1-1)
stringtoday="$(date +%Y-%m-%d -d "today")"


datefile=$(date -d $string +%s)
dateaccess=$(date -d $stringaccess +%s)
today=$(date -d $stringtoday +%s)

TOTAL=$(echo $today - $datefile  | bc)
TOTALACCESS=$(echo $today - $dateaccess  | bc)


sum=$(md5sum "$entry")
name=$(echo "${sum%% *}.${entry##*.}")

if [ "$TOTAL" -eq 86400 ] || [ "$TOTALACCESS" -eq 86400 ];
then
ln -s "$entry" ~/"ImgDownloaderBash/yesterday/$name"

  
elif [ "$TOTAL" -eq 0 ] || [ "$TOTALACCESS" -eq 0 ];
then
ln -s "$entry" ~/"ImgDownloaderBash/today/$name"
fi
fi
  
  
done





