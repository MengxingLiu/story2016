#!/bin/csh

### when p threshold = 0.005
### for Intercept and Modality  F = 9.284
### for Scale and Modality:Scale F = 5.833
### for all t test t value = 3.047
### cluster size is thresholded by alpha value = 0.05
### four paras in parenthesis are Contrast name, index of sub-brick...
### threshold of F or T value, and cluster size
cd /public/home/max/story2016fMRI/group/MVM/ 

# output positive and negative dataset separately

#    3dcalc -prefix pstv_group_MVM.nii \
#            -a group_MVM.nii \
#            -expr 'a*ispositive(a)'
#    3dcalc -prefix ngtv_group_MVM.nii \
#            -a group_MVM.nii \
#            -expr 'a*isnegative(a)'

mkdir tabout
foreach value(pstv ngtv)

foreach paras("01_Intercept 0 9.284 32" "02_Modality 1 9.284 20" \
		"03_Scale 2 5.833 31" "04_MoScale 3 5.833 29" \
		"05_Listen_CS 5 3.047 30" "06_Listen_US 7 3.047 30" \
		"07_Listen_SW 9 3.047 31" "08_Read_CS 11 3.047 30" \
		"09_Read_US 13 3.047 30" "10_Read_SW 15 3.047 32" \
		"11_Listen 17 3.047 33" "12_Read 19 3.047 33" \
		"13_Listen_CS-US 21 3.047 13" "14_Listen_CS-SW 23 3.047 25" \
		"15_Listen_US-SW 25 3.047 22" "16_Read_CS-US 27 3.047 14" \
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
        cd /public/home/max/story2016fMRI/group/MVM/
	3dclust -orient LPI \
		-nosum -1dindex 0 -1tindex 0 \
		-1thresh $threshold \
		-dxyz=1 1.01 $clustersize \
		/public/home/max/story2016fMRI/group/MVM/"$value"_group_MVM.nii\["$thindex"] | \
                grep -v '#' | dm x14 x15 x16 > checkPeak_"$value"_"$con".tmp
        3dclust -orient LPI \
		-nosum -1dindex 0 -1tindex 0 \
		-1thresh $threshold \
		-dxyz=1 1.01 $clustersize \
		/public/home/max/story2016fMRI/group/MVM/"$value"_group_MVM.nii\["$thindex"] | \
                grep -v '#' | dm s1 s11 s13 > checkValues_"$value"_"$con".tmp
        set nROIs = (`cat checkPeak_"$value"_"$con".tmp | wc | dm x1`)
        set ROI = 1
        echo "Volumes     MeanT     MaxT     MaxRL     MaxAP     MaxIS     Hemi     Label" > head.tmp
        while ( $ROI <= $nROIs )
            # Get TLRC x y z for each ROIs
            whereami -lpi -tab `cat checkPeak_"$value"_"$con".tmp | head -$ROI | tail -1 ` \
                | grep '{TLRC}' |  awk '{printf "%s\t%s\t%s\t\n",$1,$4,$7}' \
                >> peak_"$value"_"$con".tmp
            # Get Hemi and Label for each ROIs
            whereami -lpi -tab `cat checkPeak_"$value"_"$con".tmp | head -$ROI | tail -1 ` \
                | grep 'TT_Daemon' | head -1 | grep "TT_Daemon" | cut -c 21- | cut -c -34 \
                >> labels_"$value"_"$con".tmp
            @ ROI ++
        end
        abut_stat checkValues_"$value"_"$con".tmp peak_"$value"_"$con".tmp \
             labels_"$value"_"$con".tmp > tab_"$value"_"$con".tmp
        cat head.tmp tab_"$value"_"$con".tmp > tabout/"$value"_"$con".1D
        rm *.tmp 
        # Output LaTex table for each file
#        cd tabout/
#        echo "(TLRC coordinates)" > Tex_"$value"_"$con".1D
#        echo "     &     & Hemi     &     Region     &     BA     &     Voxels     &     T     & x     &     y     &     z \\" >> Tex_"$value"_"$con".1D
#        cat "$value"_"$con".1D | grep -v "Vol" | awk '{printf( "\t\&\t\&\t%1s\t\&\t %s %s %s %s\t\&\t\&\t%d\t\&\t%.2f\t\&\t%.0f\t\&\t%.0f\t\&\t\%.0f\t\\\\ \n",$7,$8,$9,$10,$11,$1,$3,$4,$5,$6)}'>> Tex_"$value"_"$con".1D
    end
end



