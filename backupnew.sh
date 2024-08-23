#!/bin/bash

echo "Making backup..."
stringnow="$(date +%Y-%m-%d_%H-%M -d "today")"
mkdir "/tmp/ImgDownloaderBashTemp" > /dev/null 2>&1

cp -r ~/"ImgDownloaderBash/new" "/tmp/ImgDownloaderBashTemp/$stringnow"
echo "Backup complete in: /tmp/$stringnow"
