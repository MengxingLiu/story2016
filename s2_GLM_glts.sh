#!/bin/sh
spath='/public/home/max/story2016fMRI'

##GLM functions
GLM()
{
echo $1
3dDeconvolve -input $1 \
	-xjpeg $2 -xsave -polort A -num_stimts 9 \
	-stim_file 1 "$spath/scripts/Wave_1Dfiles/CS1D.1d"\[0] -stim_label 1  CS \
	-stim_file 2 "$spath/scripts/Wave_1Dfiles/US1D.1d"\[0] -stim_label 2  US \
	-stim_file 3 "$spath/scripts/Wave_1Dfiles/SW1D.1d"\[0] -stim_label 3  SW \
	-stim_file 4 "motion.1D"\[0] -stim_base 4 -stim_label 4  Roll \
	-stim_file 5 "motion.1D"\[1] -stim_base 5 -stim_label 5  Pitch \
	-stim_file 6 "motion.1D"\[2] -stim_base 6 -stim_label 6 Yaw \
	-stim_file 7 "motion.1D"\[3] -stim_base 7 -stim_label 7 dS \
	-stim_file 8 "motion.1D"\[4] -stim_base 8 -stim_label 8 dL \
	-stim_file 9 "motion.1D"\[5] -stim_base 9 -stim_label 9 dP \
	-bout -tout -float -jobs 12 \
	-cbucket $2.cbucket -x1D $2.x1D \
	-bucket $2
}


GLTs()
{
3dDeconvolve -xrestore "$1.xsave" -num_glt 3 \
	-gltsym 'SYM: +CS' -glt_label 1 CS \
	-gltsym 'SYM: +US' -glt_label 2 US \
	-gltsym 'SYM: +SW' -glt_label 3 SW \
	-bout -tout -float -jobs 12 \
	-bucket "$1"_glts
}


#the results of GLM and GLM_glts (for experimetal factors) are identical. so GLG_glts were transfered to Surface model instead of GLM
for sub in sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 sub10 sub11 sub12 sub13 sub14 sub15 sub16 sub17 sub18 sub19 sub20 sub21 sub22 sub23 sub24 sub25 sub26 sub27 sub28 sub29 sub30 sub31 sub32 sub33 
	do
	cd $spath/$sub/orig_files
	rm GLM*
	echo "=================================================================="
	echo "======================= GLM: $sub================================="
	echo "=================================================================="
	
		infile1="mask_normalized_detrend_despike_reg_run01+orig mask_normalized_detrend_despike_reg_run02+orig mask_normalized_detrend_despike_reg_run03+orig mask_normalized_detrend_despike_reg_run04+orig mask_normalized_detrend_despike_reg_run05+orig" 
		
	
	GLM "$infile1" "GLM"
	
	GLTs "GLM"
	

	echo "##################################"
	echo "=========Finished: $sub =========="
	echo "##################################"

done

