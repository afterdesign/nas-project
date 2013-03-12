#!/bin/bash
function merge() {
    check_for_tiff=`ls -1 /home/scann/scans/ | grep tiff | wc -l`

    if [[ $check_for_tiff eq 0 ]]; then
        return
    fi

    files_to_merge=`ls -tr /home/scann/scans/*.tiff`

    merge_output_file="/home/scann/scans/merge_scan_`date +%Y-%m-%d-%H-%M-%S`.pdf"

    for file_tiff in $files_to_merge
    do
        file_pdf=`echo $file_tiff | sed s/tiff/pdf/ | sed s/scans/merge/`
        tiff2pdf -z $file_tiff > $file_pdf
        if [[ $? == 0 ]]; then
            rm $file_tiff
        fi
    done

    pdf_to_merge=`ls -tr /home/scann/merge/*.pdf`

    pdfunite $pdf_to_merge $merge_output_file
    if [[ $? == 0 ]]; then
        for remove_pdf in $pdf_to_merge
        do
            rm $remove_pdf
        done
    fi
}