#!/bin/bash

conttotal=0

lastweek=$("./lastusedate.sh")

echo "" | tr -d "\n" > "./tabs.txt"
tagstotal=$(cat "./tags/tagssafebooru.txt" | wc -w) 

while read -d ' ' -r line
do
if [ "$line" != "" ]
then

  \cp "./urls/urlsafebooru.txt" "/tmp/urlsafebooru.txt"
  
    replacer=$(echo "$line")
    
  sed -i "s/1girl/$replacer/g" "/tmp/urlsafebooru.txt"
    cat "/tmp/urlsafebooru.txt" > "./tabs.txt"
  
      conttotal=$((conttotal+1))
      
    "./comparesize.sh"&
    
  "./gallery-dl.bin" -i "./tabs.txt" -d ~/"ImgDownloaderBash/temp" --filter "str(date) >= '$lastweek'" -c "./gallery-dl.conf" -o 'filename={md5}.{extension}' --no-part
  
  echo "Downloads finished"
killall "comparesize.sh"


 echo "Tags done: $conttotal/$tagstotal"
  echo "Finished this tags:"
  cat "./tabs.txt"
  
 
fi
done < "./tags/tagssafebooru.txt"

 

echo "" | tr -d "\n" > "./tabs.txt"

rm -r /tmp/_MEI* > /dev/null 2>&1 ##Para borrar la basura que crea gallery-dl si no se cierra bien
