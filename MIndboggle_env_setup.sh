#!/bin/bash

cd /home/wangyun/ITA
cat /home/wangyun/ADHD_ITA/ana_test.txt | while read C; do
          ID=`$C | cut -d'/' -f4`

          #mindboggle enviromental setup
          HOST=/home/wangyun/ITA  # path on host to access input/output
          DOCK=/home/jovyan/work  # path to HOST from Docker container
          IMAGE=$DOCK/$C  # input image on HOST
          #ID=arno  # ID for brain image
          EXAMPLE=$DOCK/mindboggle_input_example
          #FREESURFER_SUBJECT=$EXAMPLE/freesurfer/subjects/$ID
          #Out=mindboggle
          singularity run \
            -B $HOST:$DOCK:ro \
            -B $PWD:$DOCK \
            -B $PWD/jovyan:/home/jovyan \
            -e mindboggle.img \
            $DOCK/$C  \
            --id $ID \
            --plugin MultiProc --plugin_args "dict(n_procs=2)" \
            --fs_openmp 5 --ants_num_threads 5 --mb_num_threads 10
      #              docker run --rm -ti -v $HOST:$DOCK nipy/mindboggle $IMAGE --id $ID
done
