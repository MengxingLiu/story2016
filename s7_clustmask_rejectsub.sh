#!/bin/csh

### when p threshold = 0.005
### for Intercept and Modality  F = 9.284
### for Scale and Modality:Scale F = 5.833
### for all t test t value = 3.047
### cluster size is thresholded by alpha value = 0.05
### four paras in parenthesis are Contrast name, index of sub-brick...
### threshold of F or T value, and cluster size
cd /public/home/max/story2016fMRI/group/MVM/ 
foreach paras("01_Intercept 0 9.284 32" "02_Modality 1 9.284 21" \
		"03_Scale 2 5.833 31" "04_Mo:Scale 3 5.833 29" \
		"05_Listen_CS 5 3.047 30" "06_Listen_US 7 3.047 30" \
		"07_Listen_SW 9 3.047 31" "08_Read_CS 11 3.047 30" \
		"09_Read_US 13 3.047 30" "10_Read_SW 15 3.047 33" \
		"11_Listen 17 3.047 32" "12_Read 19 3.047 33" \
		"13_Listen_CS-US 21 3.047 13" "14_Listen_CS-SW 23 3.047 24" \
		"15_Listen_US-SW 25 3.047 22" "16_Read_CS-US 27 3.047 17" \
		"17_Read_CS-SW 29 3.047 22" "18_Read_US-SW 31 3.047 22" \
		"19_Read-Listen 33 3.047 15") 
	set con=(`echo $paras | awk '{print $1}'`)
	set thindex=(`echo $paras | awk '{print $2}'`)
	set threshold=(`echo $paras | awk '{print $3}'`)
	set clustersize=(`echo $paras | awk '{print $4}'`)

	echo "###################################################"
	echo "########### cluster threshold for $con ############"	
	echo "######## threshold at F or T > $threshold #########"
	echo "###################################################"	

	3dclust -prefix "$con"_clustmask.nii.gz \
		-1Dformat -nosum -1dindex 0 -1tindex 0 \
		-1thresh $threshold \
		-dxyz=1 1.01 $clustersize \
		/public/home/max/story2016fMRI/group/MVM/group_MVM_rejectmotionsub.nii\["$thindex"]

end
	3dbucket *_clustmask.nii.gz -prefix groupMVM_masked_rejectsub.nii.gz



