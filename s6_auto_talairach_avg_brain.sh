#!/bin/csh

set mypath = "/public/home/max/story2016fMRI"
cd "$mypath"/group/freesurfer/SUMA/

##########################################################
####### Talairach averaged brain
###########################################################
	#------ This takes the segmentation and makes it into something automask can use to create a fuller image:
	3dcalc \
		-prefix aseg_clip.nii \
		-a aseg.nii -b brainmask.nii \
		-expr 'b*step(a)'
	
	#------ This makes a cortex only mask:
	3dAutomask -prefix automask.nii \
		-clfrac 0.1 \
		aseg_clip.nii
	
	#------ This removes the skull
	3dcalc -prefix subAvg_SurfVol_ns \
		-a subAvg_SurfVol+orig. -b automask.nii \
		-expr 'a*step(b)'
	
	#------ This does the talairaching on the no-skulled brain and other super neat files:
	@auto_tlrc -no_ss -base TT_N27+tlrc \
			-suffix _at \
			-input subAvg_SurfVol_ns+orig.			##Talairach no-skulled dataset
			
	@auto_tlrc -apar subAvg_SurfVol_ns_at+tlrc. \
			-suffix _at \
			-input subAvg_SurfVol+orig.				##Talairach skulled dataset
	
	#------ automask: from NIFIT to AFNI dataset, Then Talairach automask
	3dcalc -prefix automask -a automask.nii -expr '(a*1)'
	@auto_tlrc -rmode NN \
			-apar subAvg_SurfVol_ns_at+tlrc. \
			-suffix _at \
			-input automask+orig
	3dAFNItoNIFTI -float \
		-prefix automask_at+tlrc.nii.gz automask_at+tlrc.	
		
	#------ aseg: from NIFIT to afni   Then  Talairach aseg
	3dcalc -prefix aseg -a aseg.nii -expr '(a*1)'
	@auto_tlrc -rmode NN \
			-apar subAvg_SurfVol_ns_at+tlrc. \
			-suffix _at \
			-input aseg+orig.
	3dAFNItoNIFTI -float \
		-prefix aseg_at+tlrc.nii.gz aseg_at+tlrc.
	
################################################################################
# Convert averaged brain surfaces to talairach
################################################################################
	
	#First thing need to be done by hand: copy the spec files and edit the group name:
	cp /Users/XJWang/XJWang/bin/both_tlrc.spec ./subAvg_both+tlrc.spec
	cp /Users/XJWang/XJWang/bin/lh_tlrc.spec ./subAvg_lh+tlrc.spec
	cp /Users/XJWang/XJWang/bin/rh_tlrc.spec ./subAvg_rh+tlrc.spec
	#
	
	# Copy over volume so that ConvertSurface can read it:  
	cp subAvg_SurfVol+orig.BRIK subAvg_SurfVol_ns_at+orig.BRIK
	cp subAvg_SurfVol+orig.HEAD subAvg_SurfVol_ns_at+orig.HEAD
	
	foreach hemi (lh rh)
	foreach type (smoothwm pial white)
		ConvertSurface \
			-i_fs std."$hemi"."$type".asc \
			-o_ply std."$hemi"."$type".tlrc.ply \
			-sv subAvg_SurfVol_ns_at+orig. -tlrc
	end
	end
	
	3dAFNItoNIFTI -float -prefix subAvg_SurfVol_ns_at+tlrc.nii.gz subAvg_SurfVol_ns_at+tlrc.
	3dAFNItoNIFTI -float -prefix subAvg_SurfVol_at+tlrc.nii.gz subAvg_SurfVol_at+tlrc.

	rm subAvg_SurfVol_at+tlrc.HEAD
	rm subAvg_SurfVol_at+tlrc.BRIK
	rm subAvg_SurfVol_ns_at+tlrc.HEAD
	rm subAvg_SurfVol_ns_at+tlrc.BRIK

	cp subAvg_SurfVol_at+tlrc.nii.gz ../../

echo "=================It is finished!========================"

