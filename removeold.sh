#!/bin/bash


rm -r /tmp/_MEI* > /dev/null 2>&1 

cd ~/"ImgDownloaderBash"
ndeleted=0
for entry in ./*
do
  if [[ ! -e "$(realpath "$entry")" ]]
  then
echo "$entry broken"
rm "$entry"
fi
done

for entry in ./*
do
  

string=$(stat -c '%y' "$(realpath "$entry")" | cut -d' ' -f1-1)
stringtoday="$(date +%Y-%m-%d -d "today")"


datefile=$(date -d $string +%s)  > /dev/null 2>&1
today=$(date -d $stringtoday +%s)  > /dev/null 2>&1

TOTAL=$(echo $today - $datefile  | bc)

if [[ "$TOTAL" -gt 608400 ]]
then
if [[ -f "$entry" ]]
then
echo "File deleted: $entry with date $string"
  ndeleted=$((ndeleted+1))

rm "$entry"
fi
fi
  
done

if [[ "$ndeleted" -ne 0 ]]
then
imgdeleted="$ndeleted deleted" 
else
imgdeleted=""
fi


cd ~/"ImgDownloaderBash/temp"
ndeleted=0
for entry in ./*
do
  
string=$(stat -c '%y' "$(realpath "$entry")" | cut -d' ' -f1-1)
stringtoday="$(date +%Y-%m-%d -d "today")"


datefile=$(date -d $string +%s)  > /dev/null 2>&1
today=$(date -d $stringtoday +%s)  > /dev/null 2>&1

TOTAL=$(echo $today - $datefile  | bc)

if [[ "$TOTAL" -gt 608400 ]]
then
echo "File deleted: $entry with date $string"
  ndeleted=$((ndeleted+1))

rm "$entry"
fi
  
done

if [[ "$ndeleted" -ne 0 ]]
then
temp1deleted="$ndeleted deleted"
else
temp1deleted=""
fi



find ~/"ImgDownloaderBash/temp" -type f > "/tmp/removingImg.txt"
ndeleted=0
while read -r line
do




string=$(stat -c '%y' "$(realpath "$line")" | cut -d' ' -f1-1)
stringtoday="$(date +%Y-%m-%d -d "today")"


datefile=$(date -d $string +%s)  > /dev/null 2>&1
today=$(date -d $stringtoday +%s)  > /dev/null 2>&1

TOTAL=$(echo $today - $datefile  | bc)

if [[ "$TOTAL" -gt 608400 ]]
then
echo "File deleted: $line with date $string"
  ndeleted=$((ndeleted+1))

rm "$line"
fi

done < "/tmp/removingImg.txt"


if [[ "$ndeleted" -ne 0 ]]
then
temp2deleted="$ndeleted deleted"
else
temp2deleted=""
fi

echo "$imgdeleted
$temp1deleted
$temp2deleted"


if [[ -z "$imgdeleted" ]] && [[ -z "$temp1deleted" ]] && [[ -z "$temp2deleted" ]]
then
echo "Nothing deleted"
else
notify-send -a "ImgDownloaderBash" "$imgdeleted
$temp1deleted
$temp2deleted"
fi

