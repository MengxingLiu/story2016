#!/bin/csh

set mypath = "/public/home/max/story2016fMRI/group/"
cd "$mypath"
 
set sub = "subAvg"

### @SUMA_Make_Spec_FS: converts freesurfer files to SUMA
mkdir ./freesurfer/mri/orig
@SUMA_Make_Spec_FS -fspath freesurfer/ -sid "$sub"

#==========This script just for each individual subject, the averaged have been get from: Make_averege_subject
### @SUMA_AlignToExperiment: aligns freesurfer and SUMA volumes
#@SUMA_AlignToExperiment \
#	-exp_anat Anatomical_reg+orig \
#	-surf_anat Freesurfer/SUMA/"$sub"_SurfVol+orig \
#	-wd \
#	-prefix Anatomical_reg_AlndExp

### MapIcosahedron: puts a standard mesh on the SUMA surfaces
cd freesurfer/SUMA/
foreach hemi (lh rh)
	MapIcosahedron \
		-spec "$sub"_"$hemi".spec \
		-ld 140 \
		-prefix std.
end

# for some reason the second parc conversion fails...
cd ../
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

### Surf to Surf
cd SUMA
foreach hemi (lh rh)
	SurfToSurf \
		-prefix "$sub"_"$hemi"_std.parcellation.1D.roi \
		-i_fs std."$hemi".smoothwm.asc \
		-i_fs "$hemi".smoothwm.asc \
		-output_params Data NearestNode \
		-data "$hemi".parcellation.1D.roi\[1]
end

	echo "##################################"
	echo "=========Finished $sub =========="
	echo "##################################"
