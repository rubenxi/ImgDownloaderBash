#!/bin/bash

conttotal=0

lastweek=$("./lastusedate.sh")

echo "" | tr -d "\n" > "./tabs.txt"

while read -d ' ' -r line
do
if [ "$line" != "" ]
then

  \cp "./urls/urlkonachan.txt" "/tmp/urlkonachan.txt"
  
    replacer=$(echo "$line+date%3A%3E%3D$lastweek")
    
  sed -i "s/1girl/$replacer/g" "/tmp/urlkonachan.txt"
    cat "/tmp/urlkonachan.txt" >> "./tabs.txt"
  
      conttotal=$((conttotal+1))  
 
fi
done < "./tags/tagskonachan.txt"

tagstotal=$(cat "./tags/tagskonachan.txt" | wc -w) 

 echo "Tags done: $conttotal/$tagstotal"
 
   "./gallery-dl.bin" -i "./tabs.txt" -o 'filename={md5}.{extension}' -d ~/"ImgDownloaderBash/temp" -c "./gallery-dl.conf" --no-part
  
  echo "Finished this tags:"
  cat "./tabs.txt"

echo "" | tr -d "\n" > "./tabs.txt"

rm -r /tmp/_MEI* > /dev/null 2>&1 
