#!/bin/bash

ID=sub-15110
#mindboggle enviromental setup
HOST=/Users/posnerlab/Desktop  # path on host to access input/output
DOCK=/home/jovyan/work  # path to HOST from Docker container
IMAGE=$DOCK/example_mri_data/001.nii  # input image on HOST
#ID=arno  # ID for brain image
EXAMPLE=$DOCK/mindboggle_input_example
FREESURFER_SUBJECT=$EXAMPLE/freesurfer/subjects/$ID
#Out=mindboggle

docker run --rm -ti -v $HOST:$DOCK nipy/mindboggle $IMAGE --id $ID
