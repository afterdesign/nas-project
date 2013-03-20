#! /bin/sh
set +o noclobber
#
#   $1 = scanner device
#   $2 = friendly name
#

#
#       100,200,300,400,600
#
resolution=300;
device=$1;

if [ "`which usleep  2>/dev/null `" != '' ];then
    usleep 10000;
else
    sleep  0.01;
fi

output_file=/home/scann/scans/scan_"`date +%Y-%m-%d-%H-%M-%S`";
output_file_tiff=$output_file".tiff";

scanimage --device-name "$device" --resolution $resolution --format=tiff > $output_file_tiff  2>/dev/null;
