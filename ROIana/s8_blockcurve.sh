#!/bin/csh

# here average all block BOLD curve for each condition
# the index refered to /Wave1D_files/*1d.mx

set spath = /public/home/max/story2016fMRI
set maskpath =  /public/home/max/story2016fMRI/group/anat_ROIs
set ROIanapath =  /public/home/max/story2016fMRI/group/ROI_ana



foreach task (listen read)
     if ($task == "listen") then
        set sublist = ( sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 \
                    sub12 sub13 sub15 sub16 sub31 sub32)
    else
        set sublist = ( sub10 sub11 sub14 sub17 sub19 sub20 sub21 \
                 sub22 sub23 sub24 sub25 sub26 sub27 sub28 \
                 sub29 sub33)
    endif

foreach sub($sublist)
    cd $spath/$sub/map2subAvg
    # The previous 10 TRs are included
    # CS condtion
    3dTcat -prefix ts_cs_01.nii ts.nii\[12..27]
    3dTcat -prefix ts_cs_02.nii ts.nii\[114..129]
    3dTcat -prefix ts_cs_03.nii ts.nii\[233..248]
    3dTcat -prefix ts_cs_04.nii ts.nii\[306..321]
    3dTcat -prefix ts_cs_05.nii ts.nii\[376..391]
    3dTcat -prefix ts_cs_06.nii ts.nii\[427..442]
    3dTcat -prefix ts_cs_07.nii ts.nii\[587..602]
    3dTcat -prefix ts_cs_08.nii ts.nii\[664..679]
    3dTcat -prefix ts_cs_09.nii ts.nii\[798..813]
    3dTcat -prefix ts_cs_10.nii ts.nii\[821..836]
    # US condition
    3dTcat -prefix ts_us_01.nii ts.nii\[37..52]
    3dTcat -prefix ts_us_02.nii ts.nii\[89..104]
    3dTcat -prefix ts_us_03.nii ts.nii\[190..205]
    3dTcat -prefix ts_us_04.nii ts.nii\[278..293]
    3dTcat -prefix ts_us_05.nii ts.nii\[400..415]
    3dTcat -prefix ts_us_06.nii ts.nii\[476..491]
    3dTcat -prefix ts_us_07.nii ts.nii\[559..574]
    3dTcat -prefix ts_us_08.nii ts.nii\[610..625]
    3dTcat -prefix ts_us_09.nii ts.nii\[717..732]
    3dTcat -prefix ts_us_10.nii ts.nii\[847..862]
    # SW condition
    3dTcat -prefix ts_sw_01.nii ts.nii\[67..82]
    3dTcat -prefix ts_sw_02.nii ts.nii\[140..155]
    3dTcat -prefix ts_sw_03.nii ts.nii\[210..225]
    3dTcat -prefix ts_sw_04.nii ts.nii\[255..270]
    3dTcat -prefix ts_sw_05.nii ts.nii\[354..369]
    3dTcat -prefix ts_sw_06.nii ts.nii\[452..467]
    3dTcat -prefix ts_sw_07.nii ts.nii\[534..549]
    3dTcat -prefix ts_sw_08.nii ts.nii\[637..652]
    3dTcat -prefix ts_sw_09.nii ts.nii\[739..754]
    3dTcat -prefix ts_sw_10.nii ts.nii\[772..787]
 
    foreach type(cs us sw)
        3dMean -prefix mean_"$type"_block.nii.gz ts_"$type"_*.nii
        rm ts_"$type"_*.nii
        foreach ROI(aIFG pIFG FFG Insula SPS ATL mTC AG)
            3dmaskave -mask "$maskpath"/lh_"$ROI".nii.gz \
                mean_"$type"_block.nii.gz | dm x1 \
                | transpose > temp_beta.tmp
            echo `cat temp_beta.tmp` > \
                    "$ROIanapath"/block_curve/"$task"_"$type"_"$ROI"_"$sub".1D
            rm temp_beta.tmp
    
        end                    
    end
end
end
