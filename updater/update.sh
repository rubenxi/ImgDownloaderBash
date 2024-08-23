#!/bin/bash

version="$1"
currentversion="$2"


if [ -z "$version" ]
then

notify-send -u critical -a "ImgDownloaderBash" "Starting update of gallery-dl" 

else
rm /tmp/gallery-dl/*

mkdir /tmp/gallery-dl/
cd /tmp/gallery-dl/

wget "https://github.com/mikf/gallery-dl/releases/download/$version/gallery-dl.bin"

sleep 3



if [ -f "/tmp/gallery-dl/gallery-dl.bin" ]
then

rm "./gallery-dl.bin"
cp "/tmp/gallery-dl/gallery-dl.bin" "."



echo "$version" > "./updater/version.txt"

chmod +rwx "./gallery-dl.bin"


notify-send -a "ImgDownloaderBash" "gallery-dl updated to version: $version" 
versionprogram=$("./gallery-dl.bin" --version)
echo "gallery-dl updated to version: $versionprogram"

else
notify-send -a "ImgDownloaderBash" "Error when getting update"


fi
fi

sleep 3

