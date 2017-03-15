#!/bin/csh

set spath="/public/home/max/story2016fMRI/group/func_connect/"
# rm -rf $spath/group/surface_files
cd $spath
################ group level statistic #################
foreach ROIs( STG FFG )
	3dMVM -prefix functional_connect_"$ROIs".nii.gz -jobs 12 \
			-bsVars 'Modality' \
			-wsVars 'Scale' \
			-SS_type 2 \
			-num_glt 27 \
			-gltLabel 1 Listen_CS -gltCode 1 'Modality : 1*Listen Scale : 1*CS' \
			-gltLabel 2 Listen_US -gltCode 2 'Modality : 1*Listen Scale : 1*US' \
			-gltLabel 3 Listen_SW -gltCode 3 'Modality : 1*Listen Scale : 1*SW' \
			-gltLabel 4 Listen_NS -gltCode 4 'Modality : 1*Listen Scale : 1*NS' \
			-gltLabel 5 Read_CS -gltCode 5 'Modality : 1*Read Scale : 1*CS' \
			-gltLabel 6 Read_US -gltCode 6 'Modality : 1*Read Scale : 1*US' \
			-gltLabel 7 Read_SW -gltCode 7 'Modality : 1*Read Scale : 1*SW' \
			-gltLabel 8 Read_NS -gltCode 8 'Modality : 1*Read Scale : 1*NS' \
			-gltLabel 9 Listen -gltCode 9 'Modality : 1*Listen' \
			-gltLabel 10 Read -gltCode 10 'Modality : 1*Read' \
			-gltLabel 11 Listen_CS-US -gltCode 11 'Modality : 1*Listen Scale : 1*CS -1*US' \
			-gltLabel 12 Listen_CS-SW -gltCode 12 'Modality : 1*Listen Scale : 1*CS -1*SW' \
			-gltLabel 13 Listen_US-SW -gltCode 13 'Modality : 1*Listen Scale : 1*US -1*SW' \
			-gltLabel 14 Listen_CS-NS -gltCode 14 'Modality : 1*Listen Scale : 1*CS -1*NS' \
			-gltLabel 15 Listen_US-NS -gltCode 15 'Modality : 1*Listen Scale : 1*US -1*NS' \
			-gltLabel 16 Listen_SW-NS -gltCode 16 'Modality : 1*Listen Scale : 1*SW -1*NS' \
			-gltLabel 17 Read_CS-US -gltCode 17 'Modality : 1*Read Scale : 1*CS -1*US' \
			-gltLabel 18 Read_CS-SW -gltCode 18 'Modality : 1*Read Scale : 1*CS -1*SW' \
			-gltLabel 19 Read_US-SW -gltCode 19 'Modality : 1*Read Scale : 1*US -1*SW' \
			-gltLabel 20 Read_CS-NS -gltCode 20 'Modality : 1*Read Scale : 1*CS -1*NS' \
			-gltLabel 21 Read_US-NS -gltCode 21 'Modality : 1*Read Scale : 1*US -1*NS' \
			-gltLabel 22 Read_SW-NS -gltCode 22 'Modality : 1*Read Scale : 1*SW -1*NS' \
			-gltLabel 23 Read-Listen -gltCode 23 'Modality : 1*Read -1*Listen' \
                        -gltLabel 24 CS-L-R -gltCode 24 'Scale : 1*CS Modality: 1*Listen -1*Read' \
                        -gltLabel 25 US-L-R -gltCode 25 'Scale : 1*US Modality: 1*Listen -1*Read' \
                        -gltLabel 26 SW-L-R -gltCode 26 'Scale : 1*SW Modality: 1*Listen -1*Read' \
                        -gltLabel 27 NS-L-R -gltCode 27 'Scale : 1*NS Modality: 1*Listen -1*Read' \
                        -dataTable \
			Subj	Modality	Scale	InputFile \
			s2	Listen	CS	"$spath"/sub02/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s2	Listen	US	"$spath"/sub02/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s2	Listen	SW	"$spath"/sub02/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s2	Listen	NS	"$spath"/sub02/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s3	Listen	CS	"$spath"/sub03/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s3	Listen	US	"$spath"/sub03/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s3	Listen	SW	"$spath"/sub03/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s3	Listen	NS	"$spath"/sub03/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s4	Listen	CS	"$spath"/sub04/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s4	Listen	US	"$spath"/sub04/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s4	Listen	SW	"$spath"/sub04/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s4	Listen	NS	"$spath"/sub04/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s5	Listen	CS	"$spath"/sub05/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s5	Listen	US	"$spath"/sub05/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s5	Listen	SW	"$spath"/sub05/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s5	Listen	NS	"$spath"/sub05/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s6	Listen	CS	"$spath"/sub06/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s6	Listen	US	"$spath"/sub06/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s6	Listen	SW	"$spath"/sub06/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s6	Listen	NS	"$spath"/sub06/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s7	Listen	CS	"$spath"/sub07/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s7	Listen	US	"$spath"/sub07/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s7	Listen	SW	"$spath"/sub07/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s7	Listen	NS	"$spath"/sub07/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s8	Listen	CS	"$spath"/sub08/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s8	Listen	US	"$spath"/sub08/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s8	Listen	SW	"$spath"/sub08/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s8	Listen	NS	"$spath"/sub08/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s9	Listen	CS	"$spath"/sub09/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s9	Listen	US	"$spath"/sub09/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s9	Listen	SW	"$spath"/sub09/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s9	Listen	NS	"$spath"/sub09/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s12	Listen	CS	"$spath"/sub12/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s12	Listen	US	"$spath"/sub12/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s12	Listen	SW	"$spath"/sub12/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s12	Listen	NS	"$spath"/sub12/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s13	Listen	CS	"$spath"/sub13/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s13	Listen	US	"$spath"/sub13/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s13	Listen	SW	"$spath"/sub13/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s13	Listen	NS	"$spath"/sub13/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s15	Listen	CS	"$spath"/sub15/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s15	Listen	US	"$spath"/sub15/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s15	Listen	SW	"$spath"/sub15/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s15	Listen	NS	"$spath"/sub15/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s16	Listen	CS	"$spath"/sub16/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s16	Listen	US	"$spath"/sub16/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s16	Listen	SW	"$spath"/sub16/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s16	Listen	NS	"$spath"/sub16/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s31	Listen	CS	"$spath"/sub31/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s31	Listen	US	"$spath"/sub31/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s31	Listen	SW	"$spath"/sub31/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s31	Listen	NS	"$spath"/sub31/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s32	Listen	CS	"$spath"/sub32/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s32	Listen	US	"$spath"/sub32/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s32	Listen	SW	"$spath"/sub32/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s32	Listen	NS	"$spath"/sub32/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s10	Read	CS	"$spath"/sub10/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s10	Read	US	"$spath"/sub10/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s10	Read	SW	"$spath"/sub10/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s10	Read	NS	"$spath"/sub10/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s11	Read	CS	"$spath"/sub11/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s11	Read	US	"$spath"/sub11/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s11	Read	SW	"$spath"/sub11/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s11	Read	NS	"$spath"/sub11/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s14	Read	CS	"$spath"/sub14/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s14	Read	US	"$spath"/sub14/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s14	Read	SW	"$spath"/sub14/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s14	Read	NS	"$spath"/sub14/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s17	Read	CS	"$spath"/sub17/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s17	Read	US	"$spath"/sub17/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s17	Read	SW	"$spath"/sub17/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s17	Read	NS	"$spath"/sub17/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s19	Read	CS	"$spath"/sub19/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s19	Read	US	"$spath"/sub19/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s19	Read	SW	"$spath"/sub19/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s19	Read	NS	"$spath"/sub19/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s20	Read	CS	"$spath"/sub20/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s20	Read	US	"$spath"/sub20/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s20	Read	SW	"$spath"/sub20/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s20	Read	NS	"$spath"/sub20/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s21	Read	CS	"$spath"/sub21/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s21	Read	US	"$spath"/sub21/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s21	Read	SW	"$spath"/sub21/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s21	Read	NS	"$spath"/sub21/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s22	Read	CS	"$spath"/sub22/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s22	Read	US	"$spath"/sub22/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s22	Read	SW	"$spath"/sub22/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s22	Read	NS	"$spath"/sub22/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s23	Read	CS	"$spath"/sub23/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s23	Read	US	"$spath"/sub23/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s23	Read	SW	"$spath"/sub23/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s23	Read	NS	"$spath"/sub23/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s24	Read	CS	"$spath"/sub24/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s24	Read	US	"$spath"/sub24/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s24	Read	SW	"$spath"/sub24/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s24	Read	NS	"$spath"/sub24/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s25	Read	CS	"$spath"/sub25/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s25	Read	US	"$spath"/sub25/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s25	Read	SW	"$spath"/sub25/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s25	Read	NS	"$spath"/sub25/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s26	Read	CS	"$spath"/sub26/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s26	Read	US	"$spath"/sub26/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s26	Read	SW	"$spath"/sub26/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s26	Read	NS	"$spath"/sub26/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s27	Read	CS	"$spath"/sub27/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s27	Read	US	"$spath"/sub27/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s27	Read	SW	"$spath"/sub27/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s27	Read	NS	"$spath"/sub27/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s28	Read	CS	"$spath"/sub28/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s28	Read	US	"$spath"/sub28/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s28	Read	SW	"$spath"/sub28/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s28	Read	NS	"$spath"/sub28/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s29	Read	CS	"$spath"/sub29/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s29	Read	US	"$spath"/sub29/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s29	Read	SW	"$spath"/sub29/Corr_lh_"$ROIs"_SW_Z.nii.gz \
			s29	Read	NS	"$spath"/sub29/Corr_lh_"$ROIs"_NS_Z.nii.gz \
			s33	Read	CS	"$spath"/sub33/Corr_lh_"$ROIs"_CS_Z.nii.gz \
			s33	Read	US	"$spath"/sub33/Corr_lh_"$ROIs"_US_Z.nii.gz \
			s33	Read	SW	"$spath"/sub33/Corr_lh_"$ROIs"_SW_Z.nii.gz \
                        s33	Read	NS	"$spath"/sub33/Corr_lh_"$ROIs"_NS_Z.nii.gz 


