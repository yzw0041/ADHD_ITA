#!/bin/bash

cd /Volumes/Pegasus_wangyun/ADHD/ITA/MRI/DTI/Alex

# cat 'MDlist.txt' | while read C; do
#       dir=`echo $C | cut -d'/' -f2`
#       echo $dir
#       mrconvert $C ./$dir/MD.nii.gz
# done

cat 'nodes_2009.txt' | while read C; do

         dir=`echo $C | cut -d'/' -f1`
         mrconvert $C ./$dir/nodes_aparc.a2009s+aseg.nii.gz
done
