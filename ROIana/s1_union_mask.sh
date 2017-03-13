##################################################################
# Step 1: Get the seed region at FFG: the union of CS US SW
# #================================================================

#!/bin/csh
set spath = "/public/home/max/story2016fMRI/"
cd "$spath"/group/func_connect
     mkdir mask

     3dcalc -a "$spath"/group/MVM/Clustermask.nii.gz\[4] \
            -b "$spath"/group/MVM/Clustermask.nii.gz\[5] \
            -c "$spath"/group/MVM/Clustermask.nii.gz\[6] \
            -d "$spath"/group/anat_ROIs/lh_FFG.nii.gz \
            -expr "(step(a)+step(b)+step(c))*d" \
            -prefix ./mask/FFG_lh_listen.nii.gz 
     3dcalc -a "$spath"/group/MVM/Clustermask.nii.gz\[7] \
            -b "$spath"/group/MVM/Clustermask.nii.gz\[8] \
            -c "$spath"/group/MVM/Clustermask.nii.gz\[9] \
            -d "$spath"/group/anat_ROIs/lh_FFG.nii.gz \
            -expr "(step(a)+step(b)+step(c))*d" \
            -prefix ./mask/FFG_lh_read.nii.gz 

          
