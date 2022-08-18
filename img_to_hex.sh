#!/bin/sh
#requires ImageMagick install
#will prompt you to install it if you do not have it

help="
Thank you for using ItH (Img_to_Hex), a script made from scratch by Klein Harrigan.
If you want to contact the author of this script you can email him at: contact.kleinharrigan@gmail.com
You can find his website here: https://www.KleinKodes.com/

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
This script was designed to take a png and convert it to a text file.
The textfile is an ordered list of its pixels' hexadecimal values.
By default the alpha channel is ignored and each value is comma separated with no newlines.
Additionally, the default transparent pixel behaviour is to represent it with the decimal number 1.
This is necessary since otherwise every transparent pixel would become black without the alpha channel.
Options may be added in the future for different formats but that is not a priority.
Its sole argument should be the name of your png file without the extension.

"

if [ $# -ne 1 ]; then echo "Wrong number of arguments" ; echo "$help"; exit 2; fi

if [ $1 = "-h" ]; then echo "$help"; exit 1; fi

check=0
for i in $*; do
i="$i".png	
if [ ! -e $i ]; then echo "$i either does not exist or is a directory" ;check=1; fi; 
if [ $check -eq 1 ]; then echo "Program halted due to file not existing. Make sure to exclude png extension"; exit 2; fi;done

convert -h 1>/dev/null


if [ $? -ne 1 ]; then echo "Missing ImageMagick dependency. Will prompt it's installation (needs your password) and continue process. Press Ctrl+C to abort." 
sudo apt install imagemagick
fi

convert "$1".png txt: | tail -n +2 | sed 's/[ ][ ]*/ /g' | awk '{print "0x", $3, ", "}' | tr -d '\n' | tr -d '#' | tr -d ' ' | sed  's/,/, /g' | sed 's/0x00000000/1/g' |sed 's/FF,/,/g' > "$1".txt 

truncate -s -2 "$1".txt
