#!/bin/csh

set spath = "/public/home/max/story2016fMRI"
#########################################################################

foreach sub(sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 sub10 sub11 sub12 sub13 sub14 sub15 sub16 sub17 sub18 sub19 sub20 sub21 sub22 sub23 sub24 sub25 sub26 sub27 sub28 sub29 sub30 sub31 sub32 sub33)
	# begin putting data onto the surface 

	echo "===================== $sub ========================"

# 	mkdir "$spath"/"$sub"/surface_files/
	cd "$spath"/"$sub"/orig_files/
#	set infile = ts_normalized 
#       set infile = GLM_2_glts
        set infile = GLM.cbucket
	foreach hemi(lh rh)
		echo "Working on: $infile -->  $hemi ... "
		rm ../surface_files/"$hemi"_"$infile".1D
	
		3dVol2Surf \
			-spec ../freesurfer/SUMA/std."$sub"_"$hemi".spec \
			-surf_A smoothwm \
			-surf_B pial \
			-sv Anatomical_reg_AlndExp+orig \
			-grid_parent "$infile"+orig \
			-map_func max_abs \
			-f_steps 15 \
			-f_index voxels \
			-oob_value 0 \
			-no_headers \
			-out_1D ../surface_files/"$hemi"_"$infile".1D
	end

	echo "============ done $sub =================="

end
echo "                                         "
	echo "========================================="
    echo "=============== finished ================"
	echo "========================================="
	
