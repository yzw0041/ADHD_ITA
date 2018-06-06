#!/bin/bash

inputs=(`ls  ./*/MD_aseg2009.stats 2> /dev/null `)
if [[ ${#inputs[@]} -gt 0 ]]; then

        #===== NSPN_ID AND OCC VALUES ====================================
        # We need to edit the first two columns so they're nice and easily
        # readable with the nspn_ids etc
        echo "nspn_id,occ" > ${data_dir}/FS_ROIS/nspn_id_col
        for sub in ${inputs[@]}; do
            sub=`echo $sub | cut -d'/' -f2`
            #echo $sub
            # nspn_id is the 5 characters starting at the 10th once you've
            # taken away the data directory, and occ is the 26th character.
            echo ${sub}, #> ${data_dir}/FS_ROIS/nspn_id_col
        done
fi
