#!/bin/csh

set spath="/public/home/max/story2016fMRI"

cd $spath/group/surface_files/
################ group level statistic #################
	set infile = GLM_weighted_glts    
	foreach hemi(lh rh)

	3dttest++ -prefix "$hemi"_group_weighted_listen \
			-setA \
			"$spath"/sub02/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub03/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub04/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub05/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub06/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub07/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub08/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub09/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub12/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub13/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub15/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub16/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub31/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub32/surface_files/"$hemi"_"$infile".1D'[6]' 

	3dttest++ -prefix "$hemi"_group_weighted_read \
			-setA \
			"$spath"/sub10/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub11/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub14/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub17/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub19/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub20/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub21/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub22/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub23/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub24/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub25/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub26/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub27/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub28/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub29/surface_files/"$hemi"_"$infile".1D'[6]' \
			"$spath"/sub33/surface_files/"$hemi"_"$infile".1D'[6]' 

	end
#provide an index column for the results for 3dSurf2Vol
foreach task(listen read)
	foreach hemi(lh rh)
		1dcat "$spath"/sub02/surface_files/"$hemi"_"$infile".1D'[0]' \
			"$hemi"_group_weighted_"$task".1D \
			>> "$hemi"_group_weighted_"$task".dset
	end
#put group results back into volume world
	foreach hemi(lh rh)
	#			rm "$hemi"_group_MVM.dset
				3dSurf2Vol \
					-spec "$spath"/group/freesurfer/SUMA/subAvg_"$hemi"+tlrc.spec \
					-surf_A smoothwm \
					-surf_B pial \
					-sv ../subAvg_SurfVol_at+tlrc.nii.gz \
					-grid_parent "$spath"/sub02/GLM_2_at+tlrc.nii.gz \
					-sdata_1D "$hemi"_group_weighted_"$task".dset \
					-datum float \
					-map_func max_abs \
					-f_steps 15 \
					-f_index voxels \
					-f_p1_fr -0.2 -f_pn_fr 0.4 \
					-prefix ./"$hemi"_group_weighted_sb_"$task"
				bzip2 "$hemi"_group_weighted_"$task".dset
	end

	3dcalc \
		-float -prefix group_weighted_"$task".nii.gz \
		-a lh_group_weighted_sb_"$task"+tlrc. \
		-b rh_group_weighted_sb_"$task"+tlrc. \
		-expr '(a+b)'

end

	3dbucket \
		group_weighted_listen.nii.gz \
		group_weighted_read.nii.gz \
		-prefix group_weighted.nii.gz

	3drefit \
		-addFDR -fitt \
		-sublabel 0 Inten_Listen -sublabel 1 t-value \
		-sublabel 2 Inten_Read -sublabel 3 t-value \
		-substatpar 1 fitt 13 \
		-substatpar 3 fitt 15 \
		group_weighted.nii.gz
		
		
