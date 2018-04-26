#!/bin/bash

#find . -type d -name "sub*" | cut  -d'-' -f2
cd /Volumes/Pegasus_wangyun/ADHD/ITA/MRI/Preprocess

cat "prep_list.txt" | while read C; do
      finish=/Volumes/Pegasus_wangyun/ADHD/ITA/MRI/fmripre_outputs/fmriprep/sub-$C.html
      if [ -e "$finish" ];then
         echo "subject $C is already done"
      else

          docker run  --rm   \
               -v /Volumes/Pegasus_wangyun/ADHD/ITA/MRI/Preprocess:/bids_dataset:ro    \
               -v /Volumes/Pegasus_wangyun/ADHD/ITA/MRI/fmripre_outputs:/outputs   \
               -v /Volumes/Pegasus_wangyun/ADHD/ITA/MRI/Test_pipeline/freesurfer_license.txt:/license.txt  \
               poldracklab/fmriprep:1.0.8    \
               /bids_dataset /outputs participant \
               --participant_label  $C \
               -t rest \
               --fs-license-file "/license.txt"    \
               --ignore fieldmaps   \
               --use-aroma        \
               --force-bbr \
               --no-submm-recon  \
               --resource-monitor  \
               --write-graph  \
               --stop-on-first-crash
      fi
done
