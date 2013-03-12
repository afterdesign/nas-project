#! /bin/sh
set +o noclobber
#
#   $1 = scanner device
#   $2 = friendly name
#

#   
#       100,200,300,400,600
#
resolution=300
device=$1
mkdir -p ~/brscan
if [ "`which usleep  2>/dev/null `" != '' ];then
    usleep 10000
else
    sleep  0.01
fi

current_path=`pwd`
source "$current_path/merge_files.sh"
merge

output_file="/home/scann/scans/scan_`date +%Y-%m-%d-%H-%M-%S`.tiff"

scanimage --device-name "$device" --resolution $resolution --format=tiff > $output_file_tiff  2>/dev/null