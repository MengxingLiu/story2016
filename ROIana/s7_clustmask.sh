#!/bin/csh

### when p threshold = 0.005
### for Intercept and Modality  F = 9.284
### for Scale and Modality:Scale F = 5.833
### for all t test t value = 3.047
### cluster size is thresholded by alpha value = 0.05
### four paras in parenthesis are Contrast name, index of sub-brick...
### threshold of F or T value, and cluster size
cd /public/home/max/story2016fMRI/group/func_connect/ 
foreach paras("01_Read_CS 13 2.048" "02_Read_US 15 2.048" \
		"03_Read_SW 17 2.048 " "04_Read_NS 19 2.048")
	set con=(`echo $paras | awk '{print $1}'`)
	set thindex=(`echo $paras | awk '{print $2}'`)
	set threshold=(`echo $paras | awk '{print $3}'`)
	set clustersize = 20

	echo "###################################################"
	echo "########### cluster threshold for $con ############"	
	echo "######## threshold at F or T > $threshold #########"
	echo "###################################################"	

	3dclust -prefix "$con"_Read_FFG.nii.gz \
		-1Dformat -nosum -1dindex 0 -1tindex 0 \
		-1thresh $threshold \
		-dxyz=1 1.01 $clustersize \
		/public/home/max/story2016fMRI/group/func_connect/functional_connect_FFG.nii.gz\["$thindex"]

end
	3dbucket *_Read_FFG.nii.gz -prefix Read_FFG.nii.gz
        rm *_Read_FFG.nii.gz

cd /public/home/max/story2016fMRI/group/func_connect/ 
foreach paras("01_Listen_CS 5 2.048" "02_Listen_US 7 2.048" \
		"03_Listen_SW 9 2.048 " "04_Listen_NS 11 2.048")
	set con=(`echo $paras | awk '{print $1}'`)
	set thindex=(`echo $paras | awk '{print $2}'`)
	set threshold=(`echo $paras | awk '{print $3}'`)
	set clustersize = 20

	echo "###################################################"
	echo "########### cluster threshold for $con ############"	
	echo "######## threshold at F or T > $threshold #########"
	echo "###################################################"	

	3dclust -prefix "$con"_Listen_STG.nii.gz \
		-1Dformat -nosum -1dindex 0 -1tindex 0 \
		-1thresh $threshold \
		-dxyz=1 1.01 $clustersize \
		/public/home/max/story2016fMRI/group/func_connect/functional_connect_STG.nii.gz\["$thindex"]

end
	3dbucket *_Listen_STG.nii.gz -prefix Listen_STG.nii.gz
        rm *_Listen_STG.nii.gz


