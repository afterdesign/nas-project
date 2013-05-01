#!/bin/bash

MAIN_PATH="/home/afterdesign/scanning"
SCAN_PATH=$MAIN_PATH"/scans"
MERGE_PATH=$MAIN_PATH"/merge"

output_file=$SCAN_PATH"/scan_"`date +%Y-%m-%d-%H-%M-%S`;
output_file_tiff=$output_file".tiff";
output_file_pdf=$output_file".pdf";

resolution=300;

merge() {
    check_for_tiff=`ls -1 $SCAN_PATH/ | grep tiff | wc -l`

    if [ $check_for_tiff -eq 0 ]
    then
        return;
    fi

    files_to_merge=`ls -tr $SCAN_PATH/*.tiff`;

    merge_output_file=$SCAN_PATH"/merge_scan_"`date +%Y-%m-%d-%H-%M-%S`.pdf;

    for file_tiff in $files_to_merge
    do
        file_pdf=`echo $file_tiff | sed s/tiff/pdf/ | sed s/scans/merge/`;
        tiff2pdf -z $file_tiff > $file_pdf;
        if [ $? -eq 0 ]
        then
            rm $file_tiff;
        fi
    done

    pdf_to_merge=`ls -tr $MERGE_PATH/*.pdf`;
    echo $pdf_to_merge;
    pdfunite $pdf_to_merge $merge_output_file;

    if [ $? -eq 0 ]
    then
        for remove_pdf in $pdf_to_merge
        do
            rm $remove_pdf;
        done
    fi
}
