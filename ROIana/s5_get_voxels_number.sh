#!/bin/csh

set spath = "/public/home/max/story2016fMRI/group/func_connect"
    # subjects in reading task
    set sublist = ( sub10 sub11 sub14 sub17 sub19 sub20 \
                sub21 sub22 sub23 sub24 sub25 sub26 \
                sub27 sub28 sub29 sub33 )
    # t value = 1.993 if we set threshold p value = 0.05
    rm "$spath"/count_voxels/*
    foreach type(CS US SW NS )
        foreach sub ( $sublist )
            # get the thresholed dataset
            rm "$spath"/"$sub"/thresholded_"$type".nii.gz
            3dclust -prefix "$spath"/"$sub"/thresholded_"$type".nii.gz \
                -1Dformat -nosum -1dindex 0 -1tindex 0\
                -1thresh 2.645 -dxyz=1 1.01 1 \
                "$spath"/"$sub"/Corr_lh_FFG_"$type".nii.gz\[6]
            # count the number in STS mask
            foreach ROIs(STS IFG SPS)
                
                3dBrickStat -count -positive \
                    -mask "$spath"/mask/"$ROIs".nii.gz \
                    "$spath"/"$sub"/thresholded_"$type".nii.gz \
                    >> "$spath"/count_voxels/"$ROIs"_"$type".1D
            end
        end
    end
