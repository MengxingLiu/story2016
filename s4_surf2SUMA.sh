#!/bin/csh

set spath = "/public/home/max/story2016fMRI/"

set sub = ($1)
#foreach sub(sub01 sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 sub10 sub11 sub12 sub13 sub14 sub15) 

echo "#################  for $sub ################"
	cd "$spath"/"$sub"
 
		### @SUMA_Make_Spec_FS: converts freesurfer files to SUMA
	@SUMA_Make_Spec_FS -fspath freesurfer/ -sid "$sub"

		### @SUMA_AlignToExperiment: aligns freesurfer and SUMA volumes
	cd "$spath"/"$sub"/orig_files
	@SUMA_AlignToExperiment \
		-exp_anat Anatomical_reg+orig \
		-surf_anat ../freesurfer/SUMA/"$sub"_SurfVol+orig \
		-wd \
		-prefix Anatomical_reg_AlndExp

		### MapIcosahedron: puts a standard mesh on the SUMA surfaces
	cd "$spath"/"$sub"/freesurfer/SUMA/
	foreach hemi (lh rh)
		MapIcosahedron \
			-spec "$sub"_"$hemi".spec \
			-ld 140 \
			-prefix std. 
			## Here "std." for MacOS, but "$sub" for Linux OS
	end

	cd "$spath"/"$sub"/freesurfer/
		# for some reason the second parc conversion fails...
	foreach hemi (lh rh)
		FSread_annot \
			-input  label/"$hemi".aparc.a2009s.annot \
			-roi_1D SUMA/"$hemi".parcellation.1D.roi
	end
		#The following ROI codes cannot work correctly
		#foreach hemi (lh rh)
		#	FSread_annot \
		#		-input label/"$hemi".aparc.annot \
		#		-roi_1D SUMA/"$hemi".parcellation_2.1D.roi
		#end

	cd "$spath"/"$sub"/freesurfer/SUMA
	### Surf to Surf
	foreach hemi (lh rh)
		SurfToSurf \
			-prefix "$sub"_"$hemi"_std.parcellation.1D.roi \
			-i_fs std."$hemi".smoothwm.asc \
			-i_fs "$hemi".smoothwm.asc \
			-output_params Data NearestNode \
			-data "$hemi".parcellation.1D.roi\[1]
		end
		
		
	echo "================== done '$sub' ======================="

#end




	echo "=================================================="
	echo "=================== finished ====================="
	echo "=================================================="


