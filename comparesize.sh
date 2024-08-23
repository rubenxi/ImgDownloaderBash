#!/bin/bash
s=$1

if [ -z "$s" ]
then
s=5
fi

wait=1


while [ "$wait" -eq 1 ]; do
      tam1=$(du -hs "/home/ruben/Pictures/Grabber/temp" -b | cut -f1)
      sleep "$s"
      tam2=$(du -hs "/home/ruben/Pictures/Grabber/temp" -b | cut -f1)
  if [ "$tam1" -eq "$tam2" ]; then
    echo "";
  echo "End";
  wait=0;
  else
    echo "";
  echo "Still downloading";
  fi

done;

killall "gallery-dl.bin";



rm -r /tmp/_MEI* > /dev/null 2>&1 ##Para borrar la basura que crea gallery-dl si no se cierra bien

