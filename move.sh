#!/bin/bash

for entry in ~/"ImgDownloaderBash/temp/"*
do

if [[ -f "$entry" ]]
then
    sum=$(md5sum "$entry")
  name=$(echo "${sum%% *}.${entry##*.}")
   ln -fs "$(realpath "$entry")" ~/"ImgDownloaderBash/$name" > /dev/null 2>&1
fi
done




