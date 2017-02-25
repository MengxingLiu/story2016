#!/bin/csh

set spath="/public/home/max/story2016fMRI"
cd $spath/group/surface_files/
################ group level statistic #################
	3dMVM -prefix group_MVM_vol -jobs 12 \
			-bsVars 'Modality' \
			-wsVars 'Scale' \
			-SS_type 2 \
			-num_glt 15 \
			-gltLabel 1 Listen_CS -gltCode 1 'Modality : 1*Listen Scale : 1*CS' \
			-gltLabel 2 Listen_US -gltCode 2 'Modality : 1*Listen Scale : 1*US' \
			-gltLabel 3 Listen_SW -gltCode 3 'Modality : 1*Listen Scale : 1*SW' \
			-gltLabel 4 Read_CS -gltCode 4 'Modality : 1*Read Scale : 1*CS' \
			-gltLabel 5 Read_US -gltCode 5 'Modality : 1*Read Scale : 1*US' \
			-gltLabel 6 Read_SW -gltCode 6 'Modality : 1*Read Scale : 1*SW' \
			-gltLabel 7 Listen -gltCode 7 'Modality : 1*Listen' \
			-gltLabel 8 Read -gltCode 8 'Modality : 1*Read' \
			-gltLabel 9 Listen_CS-US -gltCode 9 'Modality : 1*Listen Scale : 1*CS -1*US' \
			-gltLabel 10 Listen_CS-SW -gltCode 10 'Modality : 1*Listen Scale : 1*CS -1*SW' \
			-gltLabel 11 Listen_US-SW -gltCode 11 'Modality : 1*Listen Scale : 1*US -1*SW' \
			-gltLabel 12 Read_CS-US -gltCode 12 'Modality : 1*Read Scale : 1*CS -1*US' \
			-gltLabel 13 Read_CS-SW -gltCode 13 'Modality : 1*Read Scale : 1*CS -1*SW' \
			-gltLabel 14 Read_US-SW -gltCode 14 'Modality : 1*Read Scale : 1*US -1*SW' \
			-gltLabel 15 Read-Listen -gltCode 15 'Modality : 1*Read -1*Listen' \
			-dataTable \
			Subj	Modality	Scale	InputFile \
			s2	Listen	CS	"$spath"/sub02/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s2	Listen	US	"$spath"/sub02/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s2	Listen	SW	"$spath"/sub02/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s3	Listen	CS	"$spath"/sub03/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s3	Listen	US	"$spath"/sub03/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s3	Listen	SW	"$spath"/sub03/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s4	Listen	CS	"$spath"/sub04/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s4	Listen	US	"$spath"/sub04/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s4	Listen	SW	"$spath"/sub04/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s5	Listen	CS	"$spath"/sub05/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s5	Listen	US	"$spath"/sub05/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s5	Listen	SW	"$spath"/sub05/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s6	Listen	CS	"$spath"/sub06/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s6	Listen	US	"$spath"/sub06/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s6	Listen	SW	"$spath"/sub06/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s7	Listen	CS	"$spath"/sub07/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s7	Listen	US	"$spath"/sub07/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s7	Listen	SW	"$spath"/sub07/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s8	Listen	CS	"$spath"/sub08/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s8	Listen	US	"$spath"/sub08/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s8	Listen	SW	"$spath"/sub08/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s9	Listen	CS	"$spath"/sub09/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s9	Listen	US	"$spath"/sub09/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s9	Listen	SW	"$spath"/sub09/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s12	Listen	CS	"$spath"/sub12/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s12	Listen	US	"$spath"/sub12/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s12	Listen	SW	"$spath"/sub12/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s13	Listen	CS	"$spath"/sub13/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s13	Listen	US	"$spath"/sub13/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s13	Listen	SW	"$spath"/sub13/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s15	Listen	CS	"$spath"/sub15/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s15	Listen	US	"$spath"/sub15/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s15	Listen	SW	"$spath"/sub15/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s16	Listen	CS	"$spath"/sub16/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s16	Listen	US	"$spath"/sub16/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s16	Listen	SW	"$spath"/sub16/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s31	Listen	CS	"$spath"/sub31/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s31	Listen	US	"$spath"/sub31/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s31	Listen	SW	"$spath"/sub31/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s32	Listen	CS	"$spath"/sub32/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s32	Listen	US	"$spath"/sub32/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s32	Listen	SW	"$spath"/sub32/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s10	Read	CS	"$spath"/sub10/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s10	Read	US	"$spath"/sub10/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s10	Read	SW	"$spath"/sub10/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s11	Read	CS	"$spath"/sub11/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s11	Read	US	"$spath"/sub11/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s11	Read	SW	"$spath"/sub11/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s14	Read	CS	"$spath"/sub14/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s14	Read	US	"$spath"/sub14/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s14	Read	SW	"$spath"/sub14/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s17	Read	CS	"$spath"/sub17/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s17	Read	US	"$spath"/sub17/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s17	Read	SW	"$spath"/sub17/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s19	Read	CS	"$spath"/sub19/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s19	Read	US	"$spath"/sub19/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s19	Read	SW	"$spath"/sub19/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s20	Read	CS	"$spath"/sub20/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s20	Read	US	"$spath"/sub20/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s20	Read	SW	"$spath"/sub20/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s21	Read	CS	"$spath"/sub21/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s21	Read	US	"$spath"/sub21/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s21	Read	SW	"$spath"/sub21/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s22	Read	CS	"$spath"/sub22/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s22	Read	US	"$spath"/sub22/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s22	Read	SW	"$spath"/sub22/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s23	Read	CS	"$spath"/sub23/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s23	Read	US	"$spath"/sub23/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s23	Read	SW	"$spath"/sub23/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s24	Read	CS	"$spath"/sub24/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s24	Read	US	"$spath"/sub24/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s24	Read	SW	"$spath"/sub24/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s25	Read	CS	"$spath"/sub25/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s25	Read	US	"$spath"/sub25/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s25	Read	SW	"$spath"/sub25/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s26	Read	CS	"$spath"/sub26/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s26	Read	US	"$spath"/sub26/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s26	Read	SW	"$spath"/sub26/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s27	Read	CS	"$spath"/sub27/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s27	Read	US	"$spath"/sub27/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s27	Read	SW	"$spath"/sub27/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s28	Read	CS	"$spath"/sub28/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s28	Read	US	"$spath"/sub28/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s28	Read	SW	"$spath"/sub28/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s29	Read	CS	"$spath"/sub29/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s29	Read	US	"$spath"/sub29/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s29	Read	SW	"$spath"/sub29/GLM_2_glts_at+tlrc.nii.gz'[4]' \
			s33	Read	CS	"$spath"/sub33/GLM_2_glts_at+tlrc.nii.gz'[0]' \
			s33	Read	US	"$spath"/sub33/GLM_2_glts_at+tlrc.nii.gz'[2]' \
			s33	Read	SW	"$spath"/sub33/GLM_2_glts_at+tlrc.nii.gz'[4]' 

