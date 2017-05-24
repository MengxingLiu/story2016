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
        
        3dTcat -prefix ts_cs_01.nii ts.nii\[12..41]
        3dTcat -prefix ts_cs_02.nii ts.nii\[114..144]
        3dTcat -prefix ts_cs_03.nii ts.nii\[233..264]
        3dTcat -prefix ts_cs_04.nii ts.nii\[306..335]
        3dTcat -prefix ts_cs_05.nii ts.nii\[376..403]
        3dTcat -prefix ts_cs_06.nii ts.nii\[427..454]
        3dTcat -prefix ts_cs_07.nii ts.nii\[587..617]
        3dTcat -prefix ts_cs_08.nii ts.nii\[664..692]
        3dTcat -prefix ts_cs_09.nii ts.nii\[798..826]
        3dTcat -prefix ts_cs_10.nii ts.nii\[821..850]
        # US condition
        3dTcat -prefix ts_us_01.nii ts.nii\[37..66]
        3dTcat -prefix ts_us_02.nii ts.nii\[89..118]
        3dTcat -prefix ts_us_03.nii ts.nii\[190..217]
        3dTcat -prefix ts_us_04.nii ts.nii\[278..308]
        3dTcat -prefix ts_us_05.nii ts.nii\[400..429]
        3dTcat -prefix ts_us_06.nii ts.nii\[476..504]
        3dTcat -prefix ts_us_07.nii ts.nii\[559..589]
        3dTcat -prefix ts_us_08.nii ts.nii\[610..637]
        3dTcat -prefix ts_us_09.nii ts.nii\[717..744]
        3dTcat -prefix ts_us_10.nii ts.nii\[847..876]
        # SW condition
        3dTcat -prefix ts_sw_01.nii ts.nii\[67..95]
        3dTcat -prefix ts_sw_02.nii ts.nii\[140..167]
        3dTcat -prefix ts_sw_03.nii ts.nii\[210..239]
        3dTcat -prefix ts_sw_04.nii ts.nii\[255..285]
        3dTcat -prefix ts_sw_05.nii ts.nii\[354..384]
        3dTcat -prefix ts_sw_06.nii ts.nii\[452..480]
        3dTcat -prefix ts_sw_07.nii ts.nii\[534..563]
        3dTcat -prefix ts_sw_08.nii ts.nii\[637..664]
        3dTcat -prefix ts_sw_09.nii ts.nii\[739..769]
        3dTcat -prefix ts_sw_10.nii ts.nii\[772..802]
        foreach block(01 02 03 04 05 06 07 08 09 10)
            foreach type(cs us sw)
                foreach ROI(aIFG pIFG FFG Insula SPS ATL mTC AG)
                    3dmaskave -mask "$maskpath"/lh_"$ROI".nii.gz \
                        ts_"$type"_"$block".nii | dm x1 \
                        | transpose > temp_beta.tmp
                                    echo `cat temp_beta.tmp` > \
                            "$ROIanapath"/block_curve/"$task"_"$type"_"$ROI"_"$sub"_"$block".1D
                    rm temp_beta.tmp
            
                end                    
            end
            rm ts_"$type"_"$block".nii

        end
    end
end
