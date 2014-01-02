#! /bin/sh
set +o noclobber
#
#   $1 = scanner device
#   $2 = friendly name
#

#
#       100,200,300,400,600
#
device=$1;

if [ "`which usleep  2>/dev/null `" != '' ];then
    usleep 10000;
else
    sleep  0.01;
fi

. /opt/brother/scanner/brscan-skey/script/merge_files.sh

scanimage --device-name "$device" --resolution $resolution --format=tiff > $output_file_tiff  2>/dev/null;
reown;