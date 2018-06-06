#!/bin/bash

export FREESURFER_HOME=/Applications/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh
PATH=/Applications/freesurfer/bin:/Applications/freesurfer/fsfast/bin:/Applications/freesurfer/tktools:/Applications/freesurfer/mni/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Applications/mricron:/Applications/MATLAB_R2016a.app/bin

cd /Volumes/Pegasus_wangyun/ADHD/ITA/MRI/DTI/Alex
for measure in MD FA; do
    echo ${measure}_CC
    find ./*/$measure.nii.gz > ${measure}_CC.txt

       cat ${measure}_CC.txt | while read C; do
           sub=`echo $C | cut -d'/' -f2`
           echo ${sub}/${measure}_mul1000.nii.gz
           if [[ ! -f ${sub}/${measure}_mul1000.nii.gz ]]; then
              /usr/local/fsl/bin/fslmaths ${C} -mul 1000 ${sub}/${measure}_mul1000.nii.gz
           fi
           mri_segstats --in   ${sub}/${measure}_mul1000.nii.gz \
                       --seg  $sub/nodes_aparc.a2009s+aseg.nii.gz \
                       --ctab  fs_a2009s.txt \
                       --sum  ./$sub/${measure}_aseg2009.stats
           # mri_segstats --in   ${sub}/${measure}_mul1000.nii.gz \
           #             --seg  $sub/nodes_aparc+aseg.nii.gz \
           #             --ctab  fs_default.txt \
           #             --sum  ./$sub/${measure}_aseg.stats


done

done
