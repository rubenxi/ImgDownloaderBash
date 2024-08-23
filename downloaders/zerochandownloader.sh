#!/bin/bash

conttotal=0

lastweek=$("./lastusedate.sh")

echo "" | tr -d "\n" > "./tabs.txt"

while read -d ' ' -r line
do
if [ "$line" != "" ]
then

  \cp "./urls/urlzerochan.txt" "/tmp/urlzerochan.txt"
  
    replacer=$(echo "$line")
    
  sed -i "s/1girl/$replacer/g" "/tmp/urlzerochan.txt"
    cat "/tmp/urlzerochan.txt" > "./tabs.txt"
  
      conttotal=$((conttotal+1))
      
    "./comparesize.sh"&
    
  "./gallery-dl.bin" -i "./tabs.txt" -d ~/"ImgDownloaderBash/temp" --filter "str(date) >= '$lastweek'" -o 'filename={md5}.{extension}' -c "./gallery-dl.conf" --no-part
  
  
  echo "Downloads finished"
killall "comparesize.sh"

tagstotal=$(cat "./tags/tagszerochan.txt" | wc -w) 

 echo "Tags done: $conttotal/$tagstotal"
  echo "Finished this tags:"
  cat "./tabs.txt"
  
 
fi
done < "./tags/tagszerochan.txt"

 

echo "" | tr -d "\n" > "./tabs.txt"

rm -r /tmp/_MEI* > /dev/null 2>&1



