#!/bin/csh

# here average all block BOLD curve for each condition
# the index refered to /Wave1D_files/*1d.mx

foreach sub(sub02)
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
 
