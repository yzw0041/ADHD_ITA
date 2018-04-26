#!/bin/bash

#find . -type d -name "sub*" | cut  -d'-' -f2
cd /Volumes/Pegasus_wangyun/ADHD/ITA/MRI/fmripre_outputs/freesurfer
# /Volumes/Pegasus_wangyun/ADHD/ITA/MRI/Preprocess
#
#  find  ./*/Structural  -mindepth 1 -maxdepth 1 -type d -exec rsync  -rR {}  /Volumes/Pegasus_wangyun/ADHD/ITA/MRI/fmripre_outputs/freesurfer  \;
find  ./sub*/*/   -mindepth 1 -maxdepth 1 -type d > file_need_move.txt

cat "file_need_move.txt" | while read C; do
        sub=`echo $C | cut -d'/' -f2`
        #mkdir sub-$sub
        mv -n  $C  $sub
done
