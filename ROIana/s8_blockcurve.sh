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
    3dTcat -prefix ts_us_03.nii ts.nii\[233..248]
    3dTcat -prefix ts_us_04.nii ts.nii\[306..321]
    3dTcat -prefix ts_us_05.nii ts.nii\[376..391]
    3dTcat -prefix ts_us_06.nii ts.nii\[427..442]
    3dTcat -prefix ts_us_07.nii ts.nii\[587..602]
    3dTcat -prefix ts_us_08.nii ts.nii\[664..679]
    3dTcat -prefix ts_us_09.nii ts.nii\[798..813]
    3dTcat -prefix ts_us_10.nii ts.nii\[821..836]
 
