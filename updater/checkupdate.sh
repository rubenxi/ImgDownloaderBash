#!/bin/bash

# antiguamente este funcionaba: version=`curl -s https://github.com/mikf/gallery-dl/releases/latest | cut -d'/' -f8-8 | cut -d'"' -f1-1`
version=`awk -F 'releases/tag/' '{print $2}' <<< "$(curl -s https://github.com/mikf/gallery-dl | grep "/releases/tag/")" | cut -d'"' -f1-1`

sizeversion=${#version}

if [ "$sizeversion" -gt 20 ]
then
notify-send -a "ImgDownloaderBash" "Error with update version"
else

currentversion=`cat "./updater/version.txt"`



if [ -z "$version" ]
then

notify-send -a "ImgDownloaderBash" "Can't get update"

else


if [ "$currentversion" != "$version" ]
then



notify-send -u critical -a  "ImgDownloaderBash" "Update available for gallery-dl: $version" 
label=$(zenity --info --text "Update available for gallery-dl: $version
Current version: $currentversion" \
--title "Update now?" \
--width=250 \
--ok-label "Update" \
--extra-button "Close" \
--extra-button "See news")


code=$?
answer="$code-$label"


echo "$answer"
if [ "$answer" = "0-" ]
then
notify-send  -a "ImgDownloaderBash" "Updating"
"./updater/update.sh" $version $currentversion
elif [ "$answer" = "1-Close" ]
then
exit
elif [ "$answer" = "1-View news" ]
then
xdg-open "https://github.com/mikf/gallery-dl/releases/latest" &
exit
fi



else

echo "gallery-dl is updated to version: $currentversion"

fi




fi
fi
