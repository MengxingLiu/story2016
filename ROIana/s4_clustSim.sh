##########################################
#	Run this script to get ClustSize at corrected pthr:
############################################
foreach type("Read_CS 12" "Read_US 14" "Read_SW 16" "Read_NS 18")
	set tt=(`echo ${type} | awk '{print $1}'`)
	set n=(`echo ${type} | awk '{print $2}'`)

	set fn = functional_connect_FFG.nii.gz\["$n"]
	
		set fx = (`3dFWHMx -dset "$fn"	| awk '{print $1}' `)
		set fy = (`3dFWHMx -dset "$fn"	| awk '{print $2}' `)
		set fz = (`3dFWHMx -dset "$fn"	| awk '{print $3}' `)
	echo "#================================================="
	echo "#===  $tt "
	echo "#================================================="
	# check  cluster size with uncrrected P thresh, -fwhmx,y,z from 3dFWHM: 
		3dClustSim -quiet -mask "$fn" -fwhmxyz $fx $fy $fz -pthr 0.05 -athr 0.05 -iter 2000 -nodec
	echo " "
	echo " "
	echo " "
end

foreach type("Listen_CS 5" "Listen_US 7" "Listen_SW 9" "Listen_NS 11")
	set tt=(`echo ${type} | awk '{print $1}'`)
	set n=(`echo ${type} | awk '{print $2}'`)

	set fn = functional_connect_STG.nii.gz\["$n"]
	
		set fx = (`3dFWHMx -dset "$fn"	| awk '{print $1}' `)
		set fy = (`3dFWHMx -dset "$fn"	| awk '{print $2}' `)
		set fz = (`3dFWHMx -dset "$fn"	| awk '{print $3}' `)
	echo "#================================================="
	echo "#===  $tt "
	echo "#================================================="
	# check  cluster size with uncrrected P thresh, -fwhmx,y,z from 3dFWHM: 
		3dClustSim -quiet -mask "$fn" -fwhmxyz $fx $fy $fz -pthr 0.05 -athr 0.05 -iter 2000 -nodec
	echo " "
	echo " "
	echo " "
end


