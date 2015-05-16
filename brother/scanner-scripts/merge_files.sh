#!/bin/bash

SCAN_PATH="/home/afterdesign/scanning/scans"

output_file=$SCAN_PATH"/scan_"`date +%Y-%m-%d-%H-%M-%S`;
output_file_tiff=$output_file".tiff";
output_file_jpg=$output_file".jpg";
output_file_pdf=$output_file".pdf";

resolution=300;

merge() {
    merge_output_file=$SCAN_PATH"/merge_scan_"`date +%Y-%m-%d-%H-%M-%S`.pdf;
    convert $SCAN_PATH/*.jpg $merge_output_file 2>&1 >/dev/null
    if [ $? -eq 0 ]
    then
        rm -rf $SCAN_PATH/*.jpg;
    fi
}

scan_to_image() {
    scanimage --device-name "$device" --resolution $resolution --format=tiff > $output_file_tiff  2>/dev/null;
    convert $output_file_tiff -quality 70 $output_file_jpg;
    if [ $? -eq 0 ]
    then
        rm -rf $output_file_tiff;
    fi
}

reown() {
    /bin/chown -R afterdesign:afterdesign $SCAN_PATH/*;
}
