#!/bin/csh

set spath = "/Users/XJWang/XJWang/workshop/story/data/ana"

#if $#argv != 1 then
#       echo "Usage: csh s6_map2SubAvg.sh [SubDirectory]"
#       echo "Please specific the subject's folder"
#else
#       set sub = $argv[1]


    mkdir $spath/$sub/map2subAvg/
    cd $spath/$sub/Surface_files

#       set glm1="GLM_SD_normalized"            #       51
#       set glm2="GLM_LD_normalized"            #       55
#       set glm3="GLM_2task_normalized"         #       97

    #set glt1="GLM_SD_normalized_glts"          #       44
    #set glt2="GLM_LD_normalized_glts"          #       44
    set glt="GLM_glts"  #       10

    foreach infile("$glt 10")
        set fn =(`echo $infile | awk '{print $1}'`)
        set n =(`echo $infile | awk '{print $2+5}'`)

        echo "Working on file: $infile ..."
        rm $spath/$sub/map2subAvg/"$fn"+tlrc.nii.gz
        
        foreach hemi (lh rh)
            1dcat "$hemi"_"$fn".1D\[0] "$hemi"_"$fn".1D\[6..$n] > "$hemi"_"$fn".dset
            3dSurf2Vol \
                -spec $spath/group/freesurfer/SUMA/subAvg_"$hemi"+tlrc.spec \
                -surf_A smoothwm \
                -surf_B pial \
                -sv $spath/group/subAvg_SurfVol_at+tlrc.nii.gz \
                -grid_parent "$spath"/"$sub"/GLM_glts_at+tlrc.nii.gz \
                -sdata_1D "$hemi"_"$fn".dset \
                -datum float \
                -map_func max_abs \
                -f_steps 15 \
                -f_index voxels \
                -f_p1_fr -0.2 -f_pn_fr 0.4 \
                -prefix ./"$hemi"_"$fn"_sb
            rm "$hemi"_"$fn".dset
        end
        
        # Put the hemispheres back together 
        3dcalc -float -prefix "$fn"+tlrc.nii.gz  \
            -a lh_"$fn"_sb+tlrc. \
            -b rh_"$fn"_sb+tlrc. \
            -expr '(a+b)'
        rm ?h_"$fn"_sb+tlrc.*
        
        #====================Get the sub-labels
        3drefit -copyaux "$spath"/"$sub"/"$fn"_at+tlrc.nii.gz "$fn"+tlrc.nii.gz 
        mv "$fn"+tlrc.nii.gz ../map2subAvg/
    end
    
#       cd $spath/$sub/map2subAvg/
#               3drefit -TR 2.5s "$ts1"+tlrc.nii.gz
#               3drefit -TR 2.5s "$ts2"+tlrc.nii.gz

    echo "============finished: $sub ============"
@ sn++
end

echo "============finished all ============"

#endif

