#!/bin/bash

cd ~/"ImgDownloaderBash/"
nmodified=0
for entry in ./*
do
  

string=$(stat -c '%y' "$(realpath "$entry")" | cut -d' ' -f1-1)
stringtoday="$(date +%Y-%m-%d -d "today")"


datefile=$(date -d $string +%s)
today=$(date -d $stringtoday +%s)

TOTAL=$(echo $today - $datefile  | bc)

if [ "$TOTAL" -gt 608400 ]
then
echo "Modified file: $entry with date $string"
  nmodified=$((nmodified+1))

touch -am "$entry"
fi
  
done

if [ "$nmodified" -ne 0 ]
then
modifiedimages="$nmodified modified" 
else
modifiedimages=""
fi

cd ~/"ImgDownloaderBash/temp"
nmodified=0
for entry in ./*
do
  
string=$(stat -c '%y' "$(realpath "$entry")" | cut -d' ' -f1-1)
stringtoday="$(date +%Y-%m-%d -d "today")"


datefile=$(date -d $string +%s)
today=$(date -d $stringtoday +%s)

TOTAL=$(echo $today - $datefile  | bc)

if [ "$TOTAL" -gt 608400 ]
then
echo "Modified file: $entry with date $string"
  nmodified=$((nmodified+1))

touch -am "$entry"
fi
  
done

if [ "$nmodified" -ne 0 ]
then
temp1modificados="$nmodified"
else
temp1modificados=""
fi



find ~/"ImgDownloaderBash/temp" -type f > "/tmp/modifyingfiles.txt"
nmodified=0
while read -r line
do


string=$(stat -c '%y' "$(realpath "$line")" | cut -d' ' -f1-1)
stringtoday="$(date +%Y-%m-%d -d "today")"


datefile=$(date -d $string +%s)
today=$(date -d $stringtoday +%s)

TOTAL=$(echo $today - $datefile  | bc)

if [ "$TOTAL" -gt 608400 ]
then
echo "Modified file: $line with date $string"
  nmodified=$((nmodified+1))

touch -am "$line"
fi

done < "/tmp/modifyingfiles.txt"

if [ "$nmodified" -ne 0 ]
then
temp2modificados="$nmodified"
else
temp2modificados=""
fi

echo "$modifiedimages
$temp1modificados
$temp2modificados"


if [ -z "$modifiedimages" ] && [ -z "$temp1modificados" ] && [ -z "$temp2modificados" ]
then 
echo "Nothing modified" 
else
notify-send -a "ImgDownloaderBash" "$modifiedimages
$temp1modificados
$temp2modificados"
fi


cd ~/"ImgDownloaderBash/"
