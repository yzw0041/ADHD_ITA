#!/bin/bash

#find . -type d -name "sub*" | cut  -d'-' -f2
cd /Volumes/Pegasus_wangyun/ADHD/ITA/MRI/Preprocess

cat "prep_list.txt" | while read C; do

              docker run  --rm         \
                    -v /Volumes/Pegasus_wangyun/ADHD/ITA/MRI/Preprocess:/data:ro      \
                    -v /Volumes/Pegasus_wangyun/ADHD/ITA/MRI/Preprocess_mriqc:/out   \
                    poldracklab/mriqc:latest          \
                    /data /out participant         \
                    --participant_label  $C \
                    --ica    \
                    --hmc-fsl \
                    --fd_thres 0.5  \
                    --no-sub  \
                    --email wang.yun.ivy@gmail.com

done
