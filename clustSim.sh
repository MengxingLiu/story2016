##########################################
#	Run this script to get ClustSize at corrected pthr:
############################################
foreach type("Intercept 0" "F_Modality 1" "F_Scale 2" "F_Mo:Scale 3" "Listen_CS 4" "Listen_US 6" "Listen_SW 8" "Read_CS 10" "Read_US 12" "Read_SW 14" "Listen 16" "Read 18" "Listen_CS-US 20" "Listen_CS-SW 22" "Listen_US-SW 24" "Read_CS-US 26" "Read_CS-SW 28" "Read_US-SW 30" "Read-Listen 32")
	set tt=(`echo ${type} | awk '{print $1}'`)
	set n=(`echo ${type} | awk '{print $2}'`)

	set fn = group_MVM_rejectmotionsub.nii\["$n"]
	
		set fx = (`3dFWHMx -dset "$fn"	| awk '{print $1}' `)
		set fy = (`3dFWHMx -dset "$fn"	| awk '{print $2}' `)
		set fz = (`3dFWHMx -dset "$fn"	| awk '{print $3}' `)
	echo "#================================================="
	echo "#===  $tt "
	echo "#================================================="
	# check  cluster size with uncrrected P thresh, -fwhmx,y,z from 3dFWHM: 
		3dClustSim -quiet -mask "$fn" -fwhmxyz $fx $fy $fz -pthr 0.005 -athr 0.05 -iter 2000 -nodec
	echo " "
	echo " "
	echo " "
end


