#!/bin/csh

set spath="/media/max/Mengxing/story2016fMRI"

################ creat a average mask ###########################

#	3dMean -prefix $spath/group/mask_group -mask_union \
			"$spath"/sub02/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub03/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub04/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub05/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub06/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub07/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub08/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub09/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub10/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub11/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub12/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub13/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub14/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub15/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub16/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub17/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub18/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub19/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub20/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub21/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub22/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub23/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub24/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub25/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub26/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub27/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub28/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub29/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub31/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub32/orig_files/GLM_at+tlrc'[41]' \
			"$spath"/sub33/orig_files/GLM_at+tlrc'[41]'

################ group level statistic ##################
	
	3dMVM -prefix group_MVM -jobs 4 \
			-bsVars 'Modality' \
			-wsVars 'Scale' \
			-SS_type 2 \
			-num_glt 15 \
			-mask "$spath"/group/mask_group+tlrc \
			-gltLabel 1 Listen_NS -gltCode 1 'Modality : 1*Listen Scale : 1*NS' \
			-gltLabel 2 Listen_CS -gltCode 2 'Modality : 1*Listen Scale : 1*CS' \
			-gltLabel 3 Listen_US -gltCode 3 'Modality : 1*Listen Scale : 1*US' \
			-gltLabel 4 Listen_SW -gltCode 4 'Modality : 1*Listen Scale : 1*SW' \
			-gltLabel 5 Listen_CS-NS -gltCode 5 'Modality : 1*Listen Scale : 1*CS -1*NS' \
			-gltLabel 6 Listen_US-NS -gltCode 6 'Modality : 1*Listen Scale : 1*US -1*NS' \
			-gltLabel 7 Listen_SW-NS -gltCode 7 'Modality : 1*Listen Scale : 1*SW -1*NS' \
			-gltLabel 8 Read_NS -gltCode 8 'Modality : 1*Read Scale : 1*NS' \
			-gltLabel 9 Read_CS -gltCode 9 'Modality : 1*Read Scale : 1*CS' \
			-gltLabel 10 Read_US -gltCode 10 'Modality : 1*Read Scale : 1*US' \
			-gltLabel 11 Read_SW -gltCode 11 'Modality : 1*Read Scale : 1*SW' \
			-gltLabel 12 Read_CS-NS -gltCode 12 'Modality : 1*Read Scale : 1*CS -1*NS' \
			-gltLabel 13 Read_US-NS -gltCode 13 'Modality : 1*Read Scale : 1*US -1*NS' \
			-gltLabel 14 Read_SW-NS -gltCode 14 'Modality : 1*Read Scale : 1*SW -1*NS' \
			-gltLabel 15 Read_Listen -gltCode 15 'Modality : 1*Read -1*Listen' \
			-dataTable \
			Subj	Modality	Scale	InputFile \
			s2	Listen	NS	"$spath"/sub02/orig_files/GLM_at+tlrc'[41]' \
			s2	Listen	CS	"$spath"/sub02/orig_files/GLM_at+tlrc'[43]' \
			s2	Listen	US	"$spath"/sub02/orig_files/GLM_at+tlrc'[45]' \
			s2	Listen	SW	"$spath"/sub02/orig_files/GLM_at+tlrc'[47]' \
			s3	Listen	NS	"$spath"/sub03/orig_files/GLM_at+tlrc'[41]' \
			s3	Listen	CS	"$spath"/sub03/orig_files/GLM_at+tlrc'[43]' \
			s3	Listen	US	"$spath"/sub03/orig_files/GLM_at+tlrc'[45]' \
			s3	Listen	SW	"$spath"/sub03/orig_files/GLM_at+tlrc'[47]' \
			s4	Listen	NS	"$spath"/sub04/orig_files/GLM_at+tlrc'[41]' \
			s4	Listen	CS	"$spath"/sub04/orig_files/GLM_at+tlrc'[43]' \
			s4	Listen	US	"$spath"/sub04/orig_files/GLM_at+tlrc'[45]' \
			s4	Listen	SW	"$spath"/sub04/orig_files/GLM_at+tlrc'[47]' \
			s5	Listen	NS	"$spath"/sub05/orig_files/GLM_at+tlrc'[41]' \
			s5	Listen	CS	"$spath"/sub05/orig_files/GLM_at+tlrc'[43]' \
			s5	Listen	US	"$spath"/sub05/orig_files/GLM_at+tlrc'[45]' \
			s5	Listen	SW	"$spath"/sub05/orig_files/GLM_at+tlrc'[47]' \
			s6	Listen	NS	"$spath"/sub06/orig_files/GLM_at+tlrc'[41]' \
			s6	Listen	CS	"$spath"/sub06/orig_files/GLM_at+tlrc'[43]' \
			s6	Listen	US	"$spath"/sub06/orig_files/GLM_at+tlrc'[45]' \
			s6	Listen	SW	"$spath"/sub06/orig_files/GLM_at+tlrc'[47]' \
			s7	Listen	NS	"$spath"/sub07/orig_files/GLM_at+tlrc'[41]' \
			s7	Listen	CS	"$spath"/sub07/orig_files/GLM_at+tlrc'[43]' \
			s7	Listen	US	"$spath"/sub07/orig_files/GLM_at+tlrc'[45]' \
			s7	Listen	SW	"$spath"/sub07/orig_files/GLM_at+tlrc'[47]' \
			s8	Listen	NS	"$spath"/sub08/orig_files/GLM_at+tlrc'[41]' \
			s8	Listen	CS	"$spath"/sub08/orig_files/GLM_at+tlrc'[43]' \
			s8	Listen	US	"$spath"/sub08/orig_files/GLM_at+tlrc'[45]' \
			s8	Listen	SW	"$spath"/sub08/orig_files/GLM_at+tlrc'[47]' \
			s9	Listen	NS	"$spath"/sub09/orig_files/GLM_at+tlrc'[41]' \
			s9	Listen	CS	"$spath"/sub09/orig_files/GLM_at+tlrc'[43]' \
			s9	Listen	US	"$spath"/sub09/orig_files/GLM_at+tlrc'[45]' \
			s9	Listen	SW	"$spath"/sub09/orig_files/GLM_at+tlrc'[47]' \
			s12	Listen	NS	"$spath"/sub12/orig_files/GLM_at+tlrc'[41]' \
			s12	Listen	CS	"$spath"/sub12/orig_files/GLM_at+tlrc'[43]' \
			s12	Listen	US	"$spath"/sub12/orig_files/GLM_at+tlrc'[45]' \
			s12	Listen	SW	"$spath"/sub12/orig_files/GLM_at+tlrc'[47]' \
			s13	Listen	NS	"$spath"/sub13/orig_files/GLM_at+tlrc'[41]' \
			s13	Listen	CS	"$spath"/sub13/orig_files/GLM_at+tlrc'[43]' \
			s13	Listen	US	"$spath"/sub13/orig_files/GLM_at+tlrc'[45]' \
			s13	Listen	SW	"$spath"/sub13/orig_files/GLM_at+tlrc'[47]' \
			s15	Listen	NS	"$spath"/sub15/orig_files/GLM_at+tlrc'[41]' \
			s15	Listen	CS	"$spath"/sub15/orig_files/GLM_at+tlrc'[43]' \
			s15	Listen	US	"$spath"/sub15/orig_files/GLM_at+tlrc'[45]' \
			s15	Listen	SW	"$spath"/sub15/orig_files/GLM_at+tlrc'[47]' \
			s16	Listen	NS	"$spath"/sub16/orig_files/GLM_at+tlrc'[41]' \
			s16	Listen	CS	"$spath"/sub16/orig_files/GLM_at+tlrc'[43]' \
			s16	Listen	US	"$spath"/sub16/orig_files/GLM_at+tlrc'[45]' \
			s16	Listen	SW	"$spath"/sub16/orig_files/GLM_at+tlrc'[47]' \
			s31	Listen	NS	"$spath"/sub31/orig_files/GLM_at+tlrc'[41]' \
			s31	Listen	CS	"$spath"/sub31/orig_files/GLM_at+tlrc'[43]' \
			s31	Listen	US	"$spath"/sub31/orig_files/GLM_at+tlrc'[45]' \
			s31	Listen	SW	"$spath"/sub31/orig_files/GLM_at+tlrc'[47]' \
			s32	Listen	NS	"$spath"/sub32/orig_files/GLM_at+tlrc'[41]' \
			s32	Listen	CS	"$spath"/sub32/orig_files/GLM_at+tlrc'[43]' \
			s32	Listen	US	"$spath"/sub32/orig_files/GLM_at+tlrc'[45]' \
			s32	Listen	SW	"$spath"/sub32/orig_files/GLM_at+tlrc'[47]' \
			s10	Read	NS	"$spath"/sub10/orig_files/GLM_at+tlrc'[41]' \
			s10	Read	CS	"$spath"/sub10/orig_files/GLM_at+tlrc'[43]' \
			s10	Read	US	"$spath"/sub10/orig_files/GLM_at+tlrc'[45]' \
			s10	Read	SW	"$spath"/sub10/orig_files/GLM_at+tlrc'[47]' \
			s11	Read	NS	"$spath"/sub11/orig_files/GLM_at+tlrc'[41]' \
			s11	Read	CS	"$spath"/sub11/orig_files/GLM_at+tlrc'[43]' \
			s11	Read	US	"$spath"/sub11/orig_files/GLM_at+tlrc'[45]' \
			s11	Read	SW	"$spath"/sub11/orig_files/GLM_at+tlrc'[47]' \
			s14	Read	NS	"$spath"/sub14/orig_files/GLM_at+tlrc'[41]' \
			s14	Read	CS	"$spath"/sub14/orig_files/GLM_at+tlrc'[43]' \
			s14	Read	US	"$spath"/sub14/orig_files/GLM_at+tlrc'[45]' \
			s14	Read	SW	"$spath"/sub14/orig_files/GLM_at+tlrc'[47]' \
			s17	Read	NS	"$spath"/sub17/orig_files/GLM_at+tlrc'[41]' \
			s17	Read	CS	"$spath"/sub17/orig_files/GLM_at+tlrc'[43]' \
			s17	Read	US	"$spath"/sub17/orig_files/GLM_at+tlrc'[45]' \
			s17	Read	SW	"$spath"/sub17/orig_files/GLM_at+tlrc'[47]' \
			s19	Read	NS	"$spath"/sub19/orig_files/GLM_at+tlrc'[41]' \
			s19	Read	CS	"$spath"/sub19/orig_files/GLM_at+tlrc'[43]' \
			s19	Read	US	"$spath"/sub19/orig_files/GLM_at+tlrc'[45]' \
			s19	Read	SW	"$spath"/sub19/orig_files/GLM_at+tlrc'[47]' \
			s20	Read	NS	"$spath"/sub20/orig_files/GLM_at+tlrc'[41]' \
			s20	Read	CS	"$spath"/sub20/orig_files/GLM_at+tlrc'[43]' \
			s20	Read	US	"$spath"/sub20/orig_files/GLM_at+tlrc'[45]' \
			s20	Read	SW	"$spath"/sub20/orig_files/GLM_at+tlrc'[47]' \
			s21	Read	NS	"$spath"/sub21/orig_files/GLM_at+tlrc'[41]' \
			s21	Read	CS	"$spath"/sub21/orig_files/GLM_at+tlrc'[43]' \
			s21	Read	US	"$spath"/sub21/orig_files/GLM_at+tlrc'[45]' \
			s21	Read	SW	"$spath"/sub21/orig_files/GLM_at+tlrc'[47]' \
			s22	Read	NS	"$spath"/sub22/orig_files/GLM_at+tlrc'[41]' \
			s22	Read	CS	"$spath"/sub22/orig_files/GLM_at+tlrc'[43]' \
			s22	Read	US	"$spath"/sub22/orig_files/GLM_at+tlrc'[45]' \
			s22	Read	SW	"$spath"/sub22/orig_files/GLM_at+tlrc'[47]' \
			s23	Read	NS	"$spath"/sub23/orig_files/GLM_at+tlrc'[41]' \
			s23	Read	CS	"$spath"/sub23/orig_files/GLM_at+tlrc'[43]' \
			s23	Read	US	"$spath"/sub23/orig_files/GLM_at+tlrc'[45]' \
			s23	Read	SW	"$spath"/sub23/orig_files/GLM_at+tlrc'[47]' \
			s24	Read	NS	"$spath"/sub24/orig_files/GLM_at+tlrc'[41]' \
			s24	Read	CS	"$spath"/sub24/orig_files/GLM_at+tlrc'[43]' \
			s24	Read	US	"$spath"/sub24/orig_files/GLM_at+tlrc'[45]' \
			s24	Read	SW	"$spath"/sub24/orig_files/GLM_at+tlrc'[47]' \
			s25	Read	NS	"$spath"/sub25/orig_files/GLM_at+tlrc'[41]' \
			s25	Read	CS	"$spath"/sub25/orig_files/GLM_at+tlrc'[43]' \
			s25	Read	US	"$spath"/sub25/orig_files/GLM_at+tlrc'[45]' \
			s25	Read	SW	"$spath"/sub25/orig_files/GLM_at+tlrc'[47]' \
			s26	Read	NS	"$spath"/sub26/orig_files/GLM_at+tlrc'[41]' \
			s26	Read	CS	"$spath"/sub26/orig_files/GLM_at+tlrc'[43]' \
			s26	Read	US	"$spath"/sub26/orig_files/GLM_at+tlrc'[45]' \
			s26	Read	SW	"$spath"/sub26/orig_files/GLM_at+tlrc'[47]' \
			s27	Read	NS	"$spath"/sub27/orig_files/GLM_at+tlrc'[41]' \
			s27	Read	CS	"$spath"/sub27/orig_files/GLM_at+tlrc'[43]' \
			s27	Read	US	"$spath"/sub27/orig_files/GLM_at+tlrc'[45]' \
			s27	Read	SW	"$spath"/sub27/orig_files/GLM_at+tlrc'[47]' \
			s28	Read	NS	"$spath"/sub28/orig_files/GLM_at+tlrc'[41]' \
			s28	Read	CS	"$spath"/sub28/orig_files/GLM_at+tlrc'[43]' \
			s28	Read	US	"$spath"/sub28/orig_files/GLM_at+tlrc'[45]' \
			s28	Read	SW	"$spath"/sub28/orig_files/GLM_at+tlrc'[47]' \
			s29	Read	NS	"$spath"/sub29/orig_files/GLM_at+tlrc'[41]' \
			s29	Read	CS	"$spath"/sub29/orig_files/GLM_at+tlrc'[43]' \
			s29	Read	US	"$spath"/sub29/orig_files/GLM_at+tlrc'[45]' \
			s29	Read	SW	"$spath"/sub29/orig_files/GLM_at+tlrc'[47]' \
			s33	Read	NS	"$spath"/sub33/orig_files/GLM_at+tlrc'[41]' \
			s33	Read	CS	"$spath"/sub33/orig_files/GLM_at+tlrc'[43]' \
			s33	Read	US	"$spath"/sub33/orig_files/GLM_at+tlrc'[45]' \
			s33	Read	SW	"$spath"/sub33/orig_files/GLM_at+tlrc'[47]' 


