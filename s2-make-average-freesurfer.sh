################################################################################
# Make an average perp
#========================================================================
#!/bin/csh

echo " Making Average Freesurfer Started at:"
date
set mypath = "/public/home/max/story2016fMRI/group"
cd "$mypath"
#====================================== Move the FS of each subject from individual folder
foreach sub(02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33)
    set subj = sub"$sub"
    echo "move Freesurfer folder to group folder: group/$subj"/
    mkdir $subj
    mv ../"$subj"/freesurfer/* ./"$subj"
end
#====================================== get the averaged FS
setenv SUBJECTS_DIR "$mypath"
make_average_subject \
     --out freesurfer \
     --subjects sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 \
                  sub10 sub11 sub12 sub13 sub14 sub15 sub16 sub17 sub18 sub19 sub20 sub21 sub22 sub23 sub24 sub25 sub26 sub27 sub28 sub29 sub30 sub31 sub32 sub33
#====================================== remove the each subject's FS back to oringinal folder
foreach sub( 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33)
     set subj = sub"$sub"
     echo "Moving freesurfer folder back to:analysis/$subj/"
     mv ./"$subj"/* ../"$subj"/freesurfer
end

echo " Making Average Freesurfer Finished at: "
date
