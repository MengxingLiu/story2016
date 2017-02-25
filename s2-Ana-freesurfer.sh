##################################################################################
#                    Freesurfer for each Subj
##=========================================================================
#!/bin/csh
set mypath = "/public/home/max/story2016fMRI"
cd "$mypath"

#foreach sub(sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 sub10 sub11 sub12 sub13 sub14 sub15 sub16 sub17 sub18 sub19 sub20 sub21 sub22 sub23 sub24 sub25 sub26 sub27 sub28 sub29 sub30 sub31 sub32 sub33)
 foreach sub($1)
echo "############################"
echo "######### $sub #############"
echo "############################"
     rm -rf "$sub"/freesurfer
	mksubjdirs "$sub"/freesurfer
     mri_convert -oi -os -it afni \
          "$sub"/orig_files/Anatomical_reg+orig.BRIK \
          "$sub"/freesurfer/mri/orig/001.mgz

     setenv SUBJECTS_DIR "$mypath"/"$sub"
     recon-all -all -subjid freesurfer &

echo "####################################"
echo "########## $sub Finished############"
echo "####################################"
end
echo "########## All Finished #########"

#recon-all
#Other Arguments (Optional)
#-sd subjectsdir : specify subjects dir (default env SUBJECTS_DIR)
