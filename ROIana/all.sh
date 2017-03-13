##################################################################
# Step 1: Get the seed region at FFG: ICs showed significant interaction
#================================================================
#!/bin/csh
set spath = "/public/home/max/story2016fMRI/"
cd "$spath"/group/func_connect
     mkdir mask
    
     3dcalc -prefix mask/FFG_lh_listen.nii.gz \
          -a "$spath"/group/MVM/Clustermask.nii.gz\[4] \   # Listen_CS
          -b "$spath"/group/MVM/Clustermask.nii.gz\[5] \   # Listen_US
          -c "$spath"/group/MVM/Clustermask.nii.gz\[6] \   # Listen_SW
          -d "$spath"/group/anat_ROIs/lh_FFG.nii.gz \      # FFG mask
          -expr "(step(a)+step(b)+step(c))*d"
     3dcalc -prefix mask/FFG_lh_read.nii.gz \
          -a "$spath"/group/MVM/Clustermask.nii.gz\[7] \   # Read_CS
          -b "$spath"/group/MVM/Clustermask.nii.gz\[8] \   # Read_US
          -c "$spath"/group/MVM/Clustermask.nii.gz\[9] \   # Read_SW
          -d "$spath"/group/anat_ROIs/lh_FFG.nii.gz \      # FFG mask
          -expr "(step(a)+step(b)+step(c))*d"


##################################################################
# Step 2: Compute the simple correlation analysis for each subject
#================================================================
#!/bin/csh
set spath = "/Users/jfyang/projects/task_VWFA/analysis"

#=====Here get the ts for each condition
foreach task( listen read)
    if $task = "listen" then
        set sublist = ( sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 \
                    sub12 sub13 sub15 sub16 sub31 sub32)
    else 
        set sublist = ( sub10 sub11 sub14 sub17 sub19 sub20 sub21 \
                 sub22 sub23 sub24 sub25 sub26 sub27 sub28 \
                 sub29 sub33)
    endif

    foreach sub( $sublist )
        #mkdir "$spath"/"$sub"/simCorrAna/
        mkdir -p "$spath"/group/func_connect/"$sub"/
        cd "$spath"/group/func_connect/"$sub"/
        echo "===========Simple Correlation Analysis for: $sub  ==================="
        set tsfile = "$spath"/"$sub"/map2subAvg/ts.nii
        3dSynthesize -cbucket "$spath"/"$sub"/map2subAvg/GLM.cbucket.nii.gz \
            -matrix "$spath"/"$sub"/orig_files/GLM.x1D -select \
            0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 24 25 26 27 28 29 \
            -prefix ts_NoInterest.nii.gz

        3dcalc -prefix ts_CleanData_All.nii.gz \
               -a $tsfile \
               -b ts_NoInterest.nii.gz \
               -expr '(a-b)'
          #     rm "$type"_NoInterest+tlrc.nii.gz
        foreach type( CS US SW NS )
                 # split the whole time series into 4 ts, for 4 conditions
            3dTcat -prefix ts_CleanData_"$type".nii.gz \
                ts_CleanData_All.nii.gz"[1dcat /public/home/max/scripts/story2016/index_$type.1D]"
           # Here 3dAutomask not worked well no-skulled dataset, so we get it from Anatomical dataset
                #3dAutomask -prefix CleanData_mask CleanData_at+tlrc
                #3dAutomask -prefix CleanData_mask Anatomical_reg_AlndExp_ns_at+tlrc
          # Here Our Dataset are based on skullstripped, so itself can be the mask
               3dmaskave -quiet -mask ts_CleanData_"$type".nii.gz \
                         ts_CleanData_"$type".nii.gz > ts_Global_"$type".1D

                3dmaskave -mask "$spath"/group/anat_ROIs/lh_FFG.nii.gz \
                          ../ts_CleanData_"$type".nii.gz | awk '{print $1}' \
                          > ts_lh_FFG_"$type".1D

               3dDeconvolve -input ../ts_CleanData_"$type".nii.gz \
                    -polort A \
                    -num_stimts 2 \
                    -stim_file 1 ts_Global_"$type".1D -stim_label 1 NoInterest \
                    -stim_file 2 ts_lh_FFG_"$type".1D -stim_label 2 lh_FFG \
                    -tout -rout \
                    -bucket Corr_lh_FFG_"$type".nii.gz
                    rm *.REML_cmd
                    rm *.xmat.1D
                    rm *.xsave
               3dcalc -prefix Corr_lh_FFG_"$type"_R.nii.gz \
                         -a Corr_lh_FFG_"$type".nii.gz'[7]' \
                         -b Corr_lh_FFG_"$type".nii.gz'[5]' \
                         -expr "ispositive(b)*sqrt(a)-isnegative(b)*sqrt(a)"
               3dcalc -prefix Corr_lh_FFG_"$type"_Z.nii.gz \
                         -a Corr_lh_FFG_"$type"_R+tlrc.nii.gz \
                         -expr 'log((1+a)/(1-a))/2'
               rm Corr_lh_FFG_"$type"_R+tlrc.nii.gz
          end
     end
end
echo "===================Finished!==================="

##################################################################
# Step 3: Do group t-test
#================================================================
#!/bin/csh
set spath = "/Users/jfyang/projects/task_VWFA/analysis"
#=================================Here get the ts for each condition
foreach type(SD LD)
     echo "==============Now, do group analysis==========="
     # Group analysis
     cd "$spath"/group/simCorrAna/icaFFG/
     foreach cond( All )
          3dttest -prefix "$type"_lh_FFG_"$cond"+tlrc.nii.gz \
               -base1 0 \
               -set2 \
               "$spath"/sub01/simCorrAna/icaFFG/"$type"_Corr_lh_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub02/simCorrAna/icaFFG/"$type"_Corr_lh_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub03/simCorrAna/icaFFG/"$type"_Corr_lh_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub04/simCorrAna/icaFFG/"$type"_Corr_lh_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub05/simCorrAna/icaFFG/"$type"_Corr_lh_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub06/simCorrAna/icaFFG/"$type"_Corr_lh_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub07/simCorrAna/icaFFG/"$type"_Corr_lh_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub08/simCorrAna/icaFFG/"$type"_Corr_lh_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub09/simCorrAna/icaFFG/"$type"_Corr_lh_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub10/simCorrAna/icaFFG/"$type"_Corr_lh_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub11/simCorrAna/icaFFG/"$type"_Corr_lh_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub12/simCorrAna/icaFFG/"$type"_Corr_lh_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub13/simCorrAna/icaFFG/"$type"_Corr_lh_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub14/simCorrAna/icaFFG/"$type"_Corr_lh_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub15/simCorrAna/icaFFG/"$type"_Corr_lh_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub16/simCorrAna/icaFFG/"$type"_Corr_lh_FFG_"$cond"_Z+tlrc.nii.gz

          3drefit -addFDR \
               -substatpar 1 fitt 15 \
               "$type"_lh_FFG_"$cond"+tlrc.nii.gz
     end
     echo "=================== "$type": done!==================="
end
echo "=================== Everything is finished!==================="

##################################################################
# Step 4: Do group contrast on LD > SD
#================================================================
#!/bin/csh
set spath = "/Users/jfyang/projects/task_VWFA/analysis"
cd "$spath"/group/simCorrAna/icaFFG/
foreach h(lh)
     foreach cond( All )
          3dttest -prefix LD-SD_"$h"_FFG_"$cond"+tlrc.nii.gz \
               -paired \
               -set1 \
               "$spath"/sub01/simCorrAna/icaFFG/SD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub02/simCorrAna/icaFFG/SD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub03/simCorrAna/icaFFG/SD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub04/simCorrAna/icaFFG/SD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub05/simCorrAna/icaFFG/SD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub06/simCorrAna/icaFFG/SD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub07/simCorrAna/icaFFG/SD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub08/simCorrAna/icaFFG/SD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub09/simCorrAna/icaFFG/SD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub10/simCorrAna/icaFFG/SD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub11/simCorrAna/icaFFG/SD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub12/simCorrAna/icaFFG/SD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub13/simCorrAna/icaFFG/SD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub14/simCorrAna/icaFFG/SD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub15/simCorrAna/icaFFG/SD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub16/simCorrAna/icaFFG/SD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               -set2 \
               "$spath"/sub01/simCorrAna/icaFFG/LD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub02/simCorrAna/icaFFG/LD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub03/simCorrAna/icaFFG/LD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub04/simCorrAna/icaFFG/LD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub05/simCorrAna/icaFFG/LD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub06/simCorrAna/icaFFG/LD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub07/simCorrAna/icaFFG/LD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub08/simCorrAna/icaFFG/LD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub09/simCorrAna/icaFFG/LD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub10/simCorrAna/icaFFG/LD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub11/simCorrAna/icaFFG/LD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub12/simCorrAna/icaFFG/LD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub13/simCorrAna/icaFFG/LD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub14/simCorrAna/icaFFG/LD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub15/simCorrAna/icaFFG/LD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz \
               "$spath"/sub16/simCorrAna/icaFFG/LD_Corr_"$h"_FFG_"$cond"_Z+tlrc.nii.gz

          3drefit -addFDR \
               -substatpar 1 fitt 15 \
               LD-SD_"$h"_FFG_"$cond"+tlrc.nii.gz
     end
end
echo "=================== LD-SD: done!==================="

##################################################################
# Step 5: Run this script to get ClustSize at corrected pthr:
#     csh do.sh | grep -v '3dClustSim' | grep -v 'Grid' | grep -v 'CLUSTER' | grep -v 'alpha' > clustSize.jfy
#================================================================
#!/bin/csh
set spath = "/Users/jfyang/projects/task_VWFA/analysis"
cd "$spath"/group/simCorrAna/icaFFG/
foreach glt(LD SD LD-SD)
     set fn = "$glt"_lh_FFG_All+tlrc.nii.gz
     set fxyz = (`3dFWHMx -dset $fn`)

          echo "#================================================="
          echo "#=== $glt :"
          echo "#================================================="

          3dClustSim -mask $fn -fwhmxyz $fxyz -iter 2500 -nodec

          echo " "
          echo " "
          echo " "
end

##################################################################
# Step 6: Do ROI list of contrast on LD > SD: TabOut
#================================================================
# Output positive and negative dataset separately
#====================================
3dcalc -prefix pstv_LD-SD_lh_FFG_All+tlrc.nii.gz \
          -a LD-SD_lh_FFG_All+tlrc.nii.gz \
          -expr 'a*ispositive(a)'

3dcalc -prefix ngtv_LD-SD_lh_FFG_All+tlrc.nii.gz \
          -a LD-SD_lh_FFG_All+tlrc.nii.gz \
          -expr 'a*negative(a)'

#====================================
#Output the label for each ROI
#==================================================================
set spath = "/Users/jfyang/projects/task_VWFA/analysis/group/simCorrAna/icaFFG"
cd "$spath"/
mkdir tabOut_LD-SD/
foreach type(pstv ngtv)
          set t_ps = 3.29
          set size = 41

          set fn = "$type"_LD-SD_lh_FFG_All+tlrc.nii.gz
          #Get ROIs raw cooridates for whereami
          3dclust -orient LPI -nosum -1dindex 1 -1tindex 1 -1thresh $t_ps -dxyz=1 1 $size "$fn" | \
                    grep -v '#' | dm x14 x15 x16 > checkPeak_"$type".tmp
          # Get Volumes, Mean and MaxInt for each ROIs
          3dclust -orient LPI -nosum -1dindex 1 -1tindex 1 -1thresh $t_ps -dxyz=1 1 $size "$fn" | \
                    grep -v '#' | dm s1 s11 s13 > checkValues_"$type".tmp

          set nROIs = (`cat checkPeak_"$type".tmp | wc | dm x1`)
          set ROI = 1
          echo "Volumes     MeanT     MaxT     MaxRL     MaxAP     MaxIS     Hemi     Label" > head.tmp
          while ( $ROI <= $nROIs )
               # Get TLRC x y z for each ROIs
               whereami -lpi -tab `cat checkPeak_"$type".tmp | head -$ROI | tail -1 ` \
                    | grep '{TLRC}' |  awk '{printf "%s\t%s\t%s\t\n",$1,$4,$7}' >> peak_"$type".tmp
          # Get Hemi and Label for each ROIs
               whereami -lpi -tab `cat checkPeak_"$type".tmp | head -$ROI | tail -1 ` \
                    | grep 'TT_Daemon' | head -1 | grep "TT_Daemon" | cut -c 21- | cut -c -34 \
                    >> labels_"$type".tmp
               @ ROI ++
          end
          abut checkValues_"$type".tmp peak_"$type".tmp labels_"$type".tmp > tab_"$type".tmp
          cat head.tmp tab_"$type".tmp > tabOut_LD-SD/"$type".1D

          rm *.tmp

          # Output LaTex table for each file
          cd tabOut_LD-SD/
          echo "(TLRC coordinates)" > Tex_"$type".1D
          echo "     &     & Hemi     &     Region     &     BA     &     Voxels     &     T     & x     &     y     &     z \\" >> Tex_"$type".1D
             cat "$type".1D | grep -v "Vol" |  awk '{printf( "\t\&\t\&\t%1s\t\&\t %s %s %s %s\t\&\t\&\t%d\t\&\t%.2f\t\&\t%.0f\t\&\t%.0f\t\&\t\%.0f\t\\\\ \n",$7,$8,$9,$10,$11,$1,$3,$4,$5,$6)}' >> Tex_"$type".1D
          cd ../
#               cat "$sfn".1D | grep -v "#" | grep -v "Vol" | dm s26 | awk '{if ($1=="---"){print ""} else {print $1}}'

end






