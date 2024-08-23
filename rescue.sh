#!/bin/bash


lastcorrectuse=$(cat "./lastopen.txt")
mkdir "/tmp/rescuedImages"

cd ~/"ImgDownloaderBash/"
nrescued=0
for entry in ./*
do
  

string=$(stat -c '%x' "$(realpath "$entry")" | cut -d' ' -f1-1)
stringm=$(stat -c '%y' "$(realpath "$entry")" | cut -d' ' -f1-1)
stringcorrect="$(date +%Y-%m-%d -d "$lastcorrectuse")"

correct=$(date -d $stringcorrect +%s)
datefile=$(date -d $string +%s)
datefilem=$(date -d $stringm +%s)


correctyesterday="$(echo $correct - 86400  | bc)"


if [ "$datefile" -eq "$correct" ] || [ "$datefile" -eq "$correctyesterday" ] || [ "$datefilem" -eq "$correct" ] || [ "$datefilem" -eq "$correctyesterday" ] && [ -f "$entry" ]
then
echo "Rescued file: $entry with date $string"
  nrescued=$((nrescued+1))
  
    sum=$(md5sum "$entry")
  name=$(echo "${sum%% *}.${entry##*.}")
   ln -s "$(realpath "$entry")" "/tmp/rescuedImages/$name" > /dev/null 2>&1
fi
  
done

if [ "$nrescued" -ne 0 ]
then
rescuedimages="$nrescued rescued" 
else
rescuedimages=""
fi



cd ~/"ImgDownloaderBash/temp"
nrescued=0
for entry in ./*
do
  
string=$(stat -c '%x' "$(realpath "$entry")" | cut -d' ' -f1-1)
stringm=$(stat -c '%y' "$(realpath "$entry")" | cut -d' ' -f1-1)
stringcorrect="$(date +%Y-%m-%d -d "$lastcorrectuse")"

correct=$(date -d $stringcorrect +%s)
datefile=$(date -d $string +%s)
datefilem=$(date -d $stringm +%s)


if [ "$datefile" -eq "$correct" ] || [ "$datefile" -eq "$correctyesterday" ] || [ "$datefilem" -eq "$correct" ] || [ "$datefilem" -eq "$correctyesterday" ] && [ -f "$entry" ]
then
echo "Rescued file: $entry with date $string"
 nrescued=$((nrescued+1))
  
    sum=$(md5sum "$entry")
  name=$(echo "${sum%% *}.${entry##*.}")
   ln -s "$(realpath "$entry")" "/tmp/rescuedImages/$name" > /dev/null 2>&1
fi
  
done

if [ "$nrescued" -ne 0 ]
then
rescuedimages1="$nrescued rescued" 
else
rescuedimages1=""
fi



find ~/"ImgDownloaderBash/temp" -type f > "/tmp/rescuingfiles.txt"
nrescued=0
while read -r line
do

string=$(stat -c '%x' "$(realpath "$line")" | cut -d' ' -f1-1)
stringm=$(stat -c '%y' "$(realpath "$entry")" | cut -d' ' -f1-1)
stringcorrect="$(date +%Y-%m-%d -d "$lastcorrectuse")"

correct=$(date -d $stringcorrect +%s)
datefile=$(date -d $string +%s)
datefilem=$(date -d $stringm +%s)

if [ "$datefile" -eq "$correct" ] || [ "$datefile" -eq "$correctyesterday" ] || [ "$datefilem" -eq "$correct" ] || [ "$datefilem" -eq "$correctyesterday" ] && [ -f "$entry" ]
then
echo "Rescued file: $entry with date $string"
 nrescued=$((nrescued+1))
  
    sum=$(md5sum "$entry")
  name=$(echo "${sum%% *}.${entry##*.}")
   ln -s "$(realpath "$entry")" "/tmp/rescuedImages/$name" > /dev/null 2>&1
fi

done < "/tmp/rescuingfiles.txt"

if [ "$nrescued" -ne 0 ]
then
rescuedimages2="$nrescued rescued"
else
rescuedimages2=""
fi

echo "$rescuedimages
$rescuedimages1
$rescuedimages2"


if [ -z "$rescuedimages" ] && [ -z "$rescuedimages1" ] && [ -z "$rescuedimages2" ]
then 
echo "Nothing modified" 
else
notify-send -a "ImgDownloaderBash" "$rescuedimages
$rescuedimages1
$rescuedimages2"
fi


cd ~/"ImgDownloaderBash/" #por si acaso

zenity --question \
       --title="Rescue finished" \
       --width=250 \
       --text="Open folder? \n $rescuedimages" 2> >(grep -v Gtk >&2)
ans=$?
if [ $ans -eq 0 ]
then
    echo "Abriendo carpeta"
    xdg-open "/tmp/rescuedImages/" > /dev/null 2>&1
    exit
else
    echo "End"
    exit
fi


