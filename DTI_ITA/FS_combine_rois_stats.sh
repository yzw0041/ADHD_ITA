#!/bin/bash
data_dir=/Volumes/Pegasus_wangyun/ADHD/ITA/MRI/DTI/Alex
cd $data_dir
mkdir FS_ROIS

for measure in MD FA; do
    echo ${measure}_CC
    #find ./*/MD_aseg2009.stats > ${measure}_aseg.txt
    inputs=(`ls  ./*/${measure}_aseg2009.stats 2> /dev/null `)
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
                echo ${sub},${sub:26:1} >> ${data_dir}/FS_ROIS/nspn_id_col
            done

       # cat ${measure}_aseg.txt | while read C; do
       #     sub=`echo $C | cut -d'/' -f2`
           for stat in mean std volume; do
                # Now write out the mean values for the measure
                asegstats2table --inputs ${inputs[@]} \
                                -t ${data_dir}/FS_ROIS/SEG_${measure}_${stat}_temp.csv \
                                -d comma \
                                --all-segs \
                                --meas ${stat}

                # Now paste the data together
                paste -d , ${data_dir}/FS_ROIS/nspn_id_col \
                            ${data_dir}/FS_ROIS/SEG_${measure}_${stat}_temp.csv \
                                > ${data_dir}/FS_ROIS/SEG_${measure}_${stat}.csv
                # asegstats2table --inputs $C \
                #                 -t $sub/SEG_${measure}_${stat}_temp.csv \
                #                 -d comma \
                #                 --all-segs \
                #                 --meas ${stat}
                #
                # # Now paste the data together
                # paste -d , ${data_dir}/FS_ROIS/nspn_id_col \
                #             ${data_dir}/FS_ROIS/SEG_${measure}_${seg}_${stat}_temp.csv \
                #                 > ${data_dir}/FS_ROIS/SEG_${measure}_${seg}_${stat}.csv

                # And replace all '-' with '_' because statsmodels in python
                # likes that more :P but only for the first line
                sed -i "1 s/-/_/g" ${data_dir}/FS_ROIS/SEG_${measure}_${stat}.csv
                # And replace the : marker
                sed -i "s/://g" ${data_dir}/FS_ROIS/SEG_${measure}_${stat}.csv

                # Remove the temporary files
                rm ${data_dir}/FS_ROIS/*temp.csv
            done
    else
         echo "    No input files for ${measure}_${seg}!"
    fi

done
