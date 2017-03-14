#!/bin/csh


set spath = "/public/home/max/story2016fMRI"

foreach sub(subAvg)
#first get the mask of each ROIs

    cd "$spath"/group/freesurfer/SUMA
    foreach hemi(lh rh)
        cat "$sub"_"$hemi"_std.parcellation.1D.roi.1D | grep -v '#' | grep -v '^$' | awk '{print $1, $3}' > "$spath"/group/"$hemi".ROIs.1D
    end

    cd "$spath"/group/
    foreach hemi(lh rh)
        rm ROIs_"$hemi".nii.gz
        3dSurf2Vol \
               -spec freesurfer/SUMA/"$sub"_"$hemi"+tlrc.spec \
               -surf_A smoothwm \
               -surf_B pial \
               -sv subAvg_SurfVol_at+tlrc.nii.gz \
               -grid_parent mask_group+tlrc. \
               -sdata_1D "$hemi".ROIs.1D \
               -datum float \
               -map_func max_abs \
               -f_steps 15 \
               -f_index voxels \
               -f_p1_fr 0.2 -f_pn_fr 0.8 \
               -prefix ./ROIs_"$hemi".nii.gz
          rm "$hemi".ROIs.1D
          # Here I set -f_pn_fr 1.2 instead of 0.4 to make sure FFG covered all voxels.
     end
end
    3dcalc -prefix STGmask.nii -a ROIs_lh.nii.gz -expr 'step(equals(a,380))'


     3dcalc \
          -float -prefix ROIs_both.nii.gz  \
          -a ROIs_lh.nii.gz \
          -b ROIs_rh.nii.gz \
          -expr '(a+b)'

mkdir anat_ROIs
mv ROIs_*h.nii.gz anat_ROIs/

cd anat_ROIs/
rm *h_*.nii.gz

# FFG 542;  STG:380 and 561
# get FFG ROI
    foreach hemi(lh rh)
        3dcalc -prefix "$hemi"_FFG.nii.gz \
               -a ROIs_"$hemi".nii.gz \
               -expr "step(equals(a,542))"
        3dcalc -prefix "$hemi"_STG.nii.gz \
                -a ROIs_"$hemi".nii.gz \
                -expr "(step(equals(a,561) + equals(a,380)))*(step(324-(y-25)*(y-25)))"
        # here we want the auditory area, so we select the STG
        # between 7<y<43 slices
     end
    
