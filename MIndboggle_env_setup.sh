#!/bin/bash

cd /Volumes/Pegasus_wangyun/ADHD/ITA/MRI
cat /home/wangyun/ADHD_ITA/ana_test.txt | while read C; do
          ID=`echo $C | cut -d'/' -f3`

          #mindboggle enviromental setup
          HOST=/Volumes/Pegasus_wangyun/ADHD/ITA/MRI  # path on host to access input/output
          DOCK=/home/jovyan/work  # path to HOST from Docker container
          IMAGE=$HOST/Preprocess/$ID/anat/${ID}_run-01_T1w.nii.gz  # input image on HOST
          #ID=arno  # ID for brain image
          #EXAMPLE=$DOCK/mindboggle_input_example
          FREESURFER_OUT=$DOCK/fmripre_outputs/freesurfer
          FREESURFER_SUBJECT=$FREESURFER_OUT/$ID
          Out=$DOCK/mindboggle
          # singularity run \
          #   -B $HOST:$DOCK:ro \
          #   -B $PWD:$DOCK \
          #   -B $PWD/jovyan:/home/jovyan \
          #   -e $HOST/mindboggle.img \
          #     $C  \
          #   --id $ID \
          #   --plugin MultiProc --plugin_args "dict(n_procs=2)" \
          #   --fs_openmp 5 --ants_num_threads 5 --mb_num_threads 10
         docker run --rm -ti -v $HOST:$DOCK nipy/mindboggle $IMAGE --id $ID
done
