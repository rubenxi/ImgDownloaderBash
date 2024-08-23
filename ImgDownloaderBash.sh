#!/bin/bash
mkdir ~/"ImgDownloaderBash" > /dev/null 2>&1
currentfolder=`pwd`
ended="$(cat "./correctend.txt")"
if [ "$ended" != "ended" ]
then
echo "The program didn't finish correctly"
echo "Last correct finish: $(cat "./lastopen.txt")"

notify-send -u critical -a  "ImgDownloaderBash" "Didn't finish correctly" 
label=$(zenity --info --text "ImgDownloaderBash" "Didn't finish correctly
Last correct finish: [$(cat "./lastopen.txt")].

If you continue all the links to saved images will be saved in the tmp folder" \
--title "Open today's folder?" \
--width=250 \
--ok-label "Open" \
--extra-button "Close and continue" \
--extra-button "Try rescue" 2> >(grep -v Gtk >&2)) 
code=$?
answer="$code-$label"


echo "$answer"
if [ "$answer" = "0-" ]
then
xdg-open ~/"ImgDownloaderBash/today"
exit
elif [ "$answer" = "1-Close and continue" ]
then
echo "Iniciando updater..."
elif [ "$answer" = "1-Try rescue" ]
then
"./rescue.sh"
exit
fi
else
echo "Starting updater..."
fi

versionprogram=$("./gallery-dl.bin" --version)
echo "Gallery-dl $versionprogram"
"./updater/checkupdate.sh"

tzerochan=$(cat "./time.txt" | grep "Zerochan" | cut -d':' -f2-2)
tkonachan=$(cat "./time.txt" | grep "Konachan" | cut -d':' -f2-2)
tsafebooru=$(cat "./time.txt" | grep "Safebooru" | cut -d':' -f2-2)

newfilesZerochan=0
newfilesKonachan=0
newfilesSafebooru=0

tdeep=$((tkonachan+tsafebooru+tzerochan))

component=$(zenity --list \
                    --title="Choose the type of search" \
                    --height=420 \
                    --width=250 \
                    --timeout=25 \
                    --ok-label="Selected/All [$tdeep m]" \
                    --cancel-label="All [$tdeep m]" \
                    --text="-All ($tdeep m): Zerochan, Konachan, Safebooru
-Selected: Choose

Select where to search:" \
                    --checklist \
                    --column="" \
                    --column="Booru" \
                    --column="time (m)" \
                    --column="Recommended" \
                    1 "Zerochan" "$tzerochan" " " 2 "Konachan" "$tkonachan" " " 3 "Safebooru" "$tsafebooru" " " 2> >(grep -v Gtk >&2)) 
ans=$?
addall=$((tkonachan + tsafebooru + tzerochan))
if [ $ans -eq 0 ]
then

    if [ "${component}" == "" ]
    then
    echo "You didn't choose, all will be used"
    component=("Zerochan Konachan Safebooru")
    currenttime="$(date +%H:%M)"
    echo "You chose: ${component}"
    echo "-------------------------------"
    echo "Estimated time: $tdeep m
Estimated finish time: $(date -d "$currenttime today + $tdeep minutes" +'%H:%M')"
    echo "-------------------------------"
    
    notify-send -i yast-timezone -a "ImgDownloaderBash" -u low "Estimated time: $tdeep m
Estimated finish time: $(date -d "$currenttime today + $tdeep minutes" +'%H:%M')"
    else
    echo "-------------------------------"
    echo "You chose: ${component}"
    echo "-------------------------------"
    relativetime=0
[[ " ${component[@]} " =~ "Zerochan" ]] && (( relativetime+=tzerochan ))
[[ " ${component[@]} " =~ "Konachan" ]] && (( relativetime+=tkonachan ))
[[ " ${component[@]} " =~ "Safebooru" ]] && (( relativetime+=tsafebooru ))

    echo "Estimated time: $relativetime m
Estimated finish time: $(date -d "$currenttime today + $relativetime minutes" +'%H:%M')"
    echo "-------------------------------"
    notify-send -i yast-timezone -a "ImgDownloaderBash" -u low "Estimated time: $relativetime m
Estimated finish time: $(date -d "$currenttime today + $relativetime minutes" +'%H:%M')"
    fi
else

   echo "All will be used"
    component=("Zerochan Konachan Safebooru")
        currenttime="$(date +%H:%M)"

    echo "You chose: ${component}"
    echo "-------------------------------"
    echo "Estimated time: $tdeep m
Estimated finish time: $(date -d "$currenttime today + $tdeep minutes" +'%H:%M')"
    echo "-------------------------------"
    notify-send -i yast-timezone -a "ImgDownloaderBash" -u low "Estimated time: $tdeep m
Estimated finish time: $(date -d "$currenttime today + $tdeep minutes" +'%H:%M')"
fi


echo "Starting..."
sleep 5
startingtime=$(date +"%H:%M")

echo " " > "./correctend.txt"


echo "Finding old files..."
"./removeold.sh"

echo "Creating temporal files..."

cd ~/"ImgDownloaderBash"
mkdir /tmp/ImgDownloaderBashTemp > /dev/null 2>&1
mkdir new > /dev/null 2>&1
mkdir ~/"ImgDownloaderBash/temp" > /dev/null 2>&1


rm /tmp/ImgDownloaderBashTemp/* > /dev/null 2>&1
rm -r ./new/* > /dev/null 2>&1
 
for entry in ~/"ImgDownloaderBash/"*
do

ln -s "$entry" "/tmp/ImgDownloaderBashTemp"  > /dev/null 2>&1
done

cd "$currentfolder"

#########

echo "LAST USE: $(cat "./lastopen.txt")"
echo "DATE TO USE: $("./lastusedate.sh")"

filesnow=0
filesnow=$(ls ~/"ImgDownloaderBash/" | wc -l)
echo "Files now: $filesnow"

echo "######################################################"
echo "###############STARTING IMAGES DOWNLOAD###############"
echo "######################################################"


echo "" | tr -d "\n" > "./tabs.txt"

startingtimeTemp=$(date +"%H:%M")
### Downloader Zerochan
filesbeforeZerochan=$(ls ~/"ImgDownloaderBash/temp" | wc -l)

[[ " ${component[@]} " =~ "Zerochan" ]] && "./downloaders/zerochandownloader.sh"
###
filesafterZerochan=$(ls ~/"ImgDownloaderBash/temp" | wc -l)

timeendTemp=$(date +"%H:%M")
tzerochan=$(($(date -d $timeendTemp +%s) - $(date -d $startingtimeTemp +%s)))
newfilesZerochan=$(echo $filesafterZerochan - $filesbeforeZerochan | bc)

startingtimeTemp=$(date +"%H:%M")
### Downloader Konachan
filesbeforeKonachan=$(ls ~/"ImgDownloaderBash/temp" | wc -l)

[[ " ${component[@]} " =~ "Konachan" ]] && "./downloaders/konachandownloader.sh"
###
filesafterKonachan=$(ls ~/"ImgDownloaderBash/temp" | wc -l)

timeendTemp=$(date +"%H:%M")
tkonachan=$(($(date -d $timeendTemp +%s) - $(date -d $startingtimeTemp +%s)))
newfilesKonachan=$(echo $filesafterKonachan - $filesbeforeKonachan | bc)

startingtimeTemp=$(date +"%H:%M")
### Downloader Safebooru
filesbeforeSafebooru=$(ls ~/"ImgDownloaderBash/temp" | wc -l)

[[ " ${component[@]} " =~ "Safebooru" ]] && "./downloaders/safeboorudownloader.sh"
###
filesafterSafebooru=$(ls ~/"ImgDownloaderBash/temp" | wc -l)

timeendTemp=$(date +"%H:%M")
tsafebooru=$(($(date -d $timeendTemp +%s) - $(date -d $startingtimeTemp +%s)))
newfilesSafebooru=$(echo $filesafterSafebooru - $filesbeforeSafebooru | bc)

################

if [ $tzerochan -gt 0 ] ; then sed -i "/Zerochan/c\Zerochan:$((tzerochan/60))" "./time.txt"; fi
if [ $tkonachan -gt 0 ] ; then sed -i "/Konachan/c\Konachan:$((tkonachan/60))" "./time.txt"; fi
if [ $tsafebooru -gt 0 ] ; then sed -i "/Safebooru/c\Safebooru:$((tsafebooru/60))" "./time.txt"; fi

echo "----------------------------------"
sleep 5

echo ""
echo "############################################################"

today="$(date +%Y-%m-%d -d "today")"
echo "$today" > "./lastopen.txt"
echo "UPDATED LAST USE DATE TO: $(cat "./lastopen.txt")"


echo "Finished the download of new images"

startingtimeH=$(echo "$startingtime" | cut -d':' -f1-1)
midnighttimeH=$(date +"%H:%M" | cut -d':' -f1-1)

if [ "$startingtimeH" = "23" ] && [ "$midnighttimeH" = "00" ];
then
echo "No file will be modified since it's midnight"
elif  [ "$startingtimeH" = "23" ] && [ "$midnighttimeH" = "01" ];
then
echo "No file will be modified since it's midnight"
else
echo "Searching for images with incorrect date..."
"./resetmodifiedfiles.sh"
fi

echo "Moving files..."
"./move.sh"
  
 
    
filesafter=0
filesafter=$(ls ~/"ImgDownloaderBash/" | wc -l)
echo "Files now: $filesafter"

newfiles=0
echo "$filesafter - $filesnow"
newfiles=$(echo $filesafter - $filesnow  | bc)
echo "[$newfiles] new imagenes"
timeend=$(date +"%H:%M")

echo "Sorting in folders..."
"./getnew.sh"

echo "Comparing and moving new files..."
new=$(diff "/tmp/ImgDownloaderBashTemp/" ~/"ImgDownloaderBash/")
new2=$(echo "$new" | cut -d':' -f2-2 | cut -d' ' -f2-)

cd ~/"ImgDownloaderBash/"

while read -r line
do
 sum=$(md5sum "$line")
  name=$(echo "${sum%% *}.${line##*.}")
ln -s "$(realpath "$line")" ~/"ImgDownloaderBash/new/$name"  > /dev/null 2>&1
done <<< "$new2"

echo "################################"
echo ""
echo "End of the tags."
echo "----------------------------------

Images found:

Zerochan: $newfilesZerochan
Konachan: $newfilesKonachan
Safebooru: $newfilesSafebooru

TOTAL: [$newfiles] NEW IMAGES. 
[$startingtime - $timeend]"

notify-send -a "ImgDownloaderBash" "End of the tags reached, there are $newfiles new imagenes. $startingtime - $timeend"
cd "$currentfolder"
"./backupnew.sh"

echo "ended" > "./correctend.txt"

rm -r /tmp/_MEI* > /dev/null 2>&1 

echo "#######################################################"
echo "##############FINISHED YOU CAN CLOSE THIS##############"
echo "#######################################################"


zenity --question \
       --title="Finished image download, do you want to open the folder?" \
       --width=250 \
       --text="Go to folder? \n $newfiles new images \n $startingtime - $timeend" 2> >(grep -v Gtk >&2)
ans=$?
if [ $ans -eq 0 ]
then
    echo "Opening folder"
    xdg-open ~/"ImgDownloaderBash/new/" > /dev/null 2>&1
    exit
else
    echo "End"
    exit
fi
