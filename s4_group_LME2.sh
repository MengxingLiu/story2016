#!/bin/csh
#this script do linear trend.
# code "condition" as a quantitative variable
# reference: https://afni.nimh.nih.gov/afni/community/board/read.php?1,149234,153119#msg-153119
# set CS=1 US=0 SW=-1
set spath="/public/home/max/story2016fMRI"
# rm -rf $spath/group/surface_files
cd $spath/group/surface_files/
################ group level statistic #################
	3dLME -prefix group_vol_LME -jobs 12 \
			-model "Modality*Scale" \
			-qVars "Scale" -ranEff '~Scale' \
			-num_glt 2 \
			-gltLabel 1 LTrend -gltCode 1 'Modality : 1*Listen Scale : ' \
			-gltLabel 2 RTrend -gltCode 2 'Modality : 1*Read Scale : ' \
			-dataTable \
			Subj	Modality	Scale	InputFile \
			s2	Listen	1	"$spath"/sub02/GLM_glts_at+tlrc.nii.gz'[0]' \
			s2	Listen	0	"$spath"/sub02/GLM_glts_at+tlrc.nii.gz'[2]' \
			s2	Listen	-1	"$spath"/sub02/GLM_glts_at+tlrc.nii.gz'[4]' \
			s3	Listen	1	"$spath"/sub03/GLM_glts_at+tlrc.nii.gz'[0]' \
			s3	Listen	0	"$spath"/sub03/GLM_glts_at+tlrc.nii.gz'[2]' \
			s3	Listen	-1	"$spath"/sub03/GLM_glts_at+tlrc.nii.gz'[4]' \
			s4	Listen	1	"$spath"/sub04/GLM_glts_at+tlrc.nii.gz'[0]' \
			s4	Listen	0	"$spath"/sub04/GLM_glts_at+tlrc.nii.gz'[2]' \
			s4	Listen	-1	"$spath"/sub04/GLM_glts_at+tlrc.nii.gz'[4]' \
			s5	Listen	1	"$spath"/sub05/GLM_glts_at+tlrc.nii.gz'[0]' \
			s5	Listen	0	"$spath"/sub05/GLM_glts_at+tlrc.nii.gz'[2]' \
			s5	Listen	-1	"$spath"/sub05/GLM_glts_at+tlrc.nii.gz'[4]' \
			s6	Listen	1	"$spath"/sub06/GLM_glts_at+tlrc.nii.gz'[0]' \
			s6	Listen	0	"$spath"/sub06/GLM_glts_at+tlrc.nii.gz'[2]' \
			s6	Listen	-1	"$spath"/sub06/GLM_glts_at+tlrc.nii.gz'[4]' \
			s7	Listen	1	"$spath"/sub07/GLM_glts_at+tlrc.nii.gz'[0]' \
			s7	Listen	0	"$spath"/sub07/GLM_glts_at+tlrc.nii.gz'[2]' \
			s7	Listen	-1	"$spath"/sub07/GLM_glts_at+tlrc.nii.gz'[4]' \
			s8	Listen	1	"$spath"/sub08/GLM_glts_at+tlrc.nii.gz'[0]' \
			s8	Listen	0	"$spath"/sub08/GLM_glts_at+tlrc.nii.gz'[2]' \
			s8	Listen	-1	"$spath"/sub08/GLM_glts_at+tlrc.nii.gz'[4]' \
			s9	Listen	1	"$spath"/sub09/GLM_glts_at+tlrc.nii.gz'[0]' \
			s9	Listen	0	"$spath"/sub09/GLM_glts_at+tlrc.nii.gz'[2]' \
			s9	Listen	-1	"$spath"/sub09/GLM_glts_at+tlrc.nii.gz'[4]' \
			s12	Listen	1	"$spath"/sub12/GLM_glts_at+tlrc.nii.gz'[0]' \
			s12	Listen	0	"$spath"/sub12/GLM_glts_at+tlrc.nii.gz'[2]' \
			s12	Listen	-1	"$spath"/sub12/GLM_glts_at+tlrc.nii.gz'[4]' \
			s13	Listen	1	"$spath"/sub13/GLM_glts_at+tlrc.nii.gz'[0]' \
			s13	Listen	0	"$spath"/sub13/GLM_glts_at+tlrc.nii.gz'[2]' \
			s13	Listen	-1	"$spath"/sub13/GLM_glts_at+tlrc.nii.gz'[4]' \
			s15	Listen	1	"$spath"/sub15/GLM_glts_at+tlrc.nii.gz'[0]' \
			s15	Listen	0	"$spath"/sub15/GLM_glts_at+tlrc.nii.gz'[2]' \
			s15	Listen	-1	"$spath"/sub15/GLM_glts_at+tlrc.nii.gz'[4]' \
			s16	Listen	1	"$spath"/sub16/GLM_glts_at+tlrc.nii.gz'[0]' \
			s16	Listen	0	"$spath"/sub16/GLM_glts_at+tlrc.nii.gz'[2]' \
			s16	Listen	-1	"$spath"/sub16/GLM_glts_at+tlrc.nii.gz'[4]' \
			s31	Listen	1	"$spath"/sub31/GLM_glts_at+tlrc.nii.gz'[0]' \
			s31	Listen	0	"$spath"/sub31/GLM_glts_at+tlrc.nii.gz'[2]' \
			s31	Listen	-1	"$spath"/sub31/GLM_glts_at+tlrc.nii.gz'[4]' \
			s32	Listen	1	"$spath"/sub32/GLM_glts_at+tlrc.nii.gz'[0]' \
			s32	Listen	0	"$spath"/sub32/GLM_glts_at+tlrc.nii.gz'[2]' \
			s32	Listen	-1	"$spath"/sub32/GLM_glts_at+tlrc.nii.gz'[4]' \
			s10	Read	1	"$spath"/sub10/GLM_glts_at+tlrc.nii.gz'[0]' \
			s10	Read	0	"$spath"/sub10/GLM_glts_at+tlrc.nii.gz'[2]' \
			s10	Read	-1	"$spath"/sub10/GLM_glts_at+tlrc.nii.gz'[4]' \
			s11	Read	1	"$spath"/sub11/GLM_glts_at+tlrc.nii.gz'[0]' \
			s11	Read	0	"$spath"/sub11/GLM_glts_at+tlrc.nii.gz'[2]' \
			s11	Read	-1	"$spath"/sub11/GLM_glts_at+tlrc.nii.gz'[4]' \
			s14	Read	1	"$spath"/sub14/GLM_glts_at+tlrc.nii.gz'[0]' \
			s14	Read	0	"$spath"/sub14/GLM_glts_at+tlrc.nii.gz'[2]' \
			s14	Read	-1	"$spath"/sub14/GLM_glts_at+tlrc.nii.gz'[4]' \
			s17	Read	1	"$spath"/sub17/GLM_glts_at+tlrc.nii.gz'[0]' \
			s17	Read	0	"$spath"/sub17/GLM_glts_at+tlrc.nii.gz'[2]' \
			s17	Read	-1	"$spath"/sub17/GLM_glts_at+tlrc.nii.gz'[4]' \
			s19	Read	1	"$spath"/sub19/GLM_glts_at+tlrc.nii.gz'[0]' \
			s19	Read	0	"$spath"/sub19/GLM_glts_at+tlrc.nii.gz'[2]' \
			s19	Read	-1	"$spath"/sub19/GLM_glts_at+tlrc.nii.gz'[4]' \
			s20	Read	1	"$spath"/sub20/GLM_glts_at+tlrc.nii.gz'[0]' \
			s20	Read	0	"$spath"/sub20/GLM_glts_at+tlrc.nii.gz'[2]' \
			s20	Read	-1	"$spath"/sub20/GLM_glts_at+tlrc.nii.gz'[4]' \
			s21	Read	1	"$spath"/sub21/GLM_glts_at+tlrc.nii.gz'[0]' \
			s21	Read	0	"$spath"/sub21/GLM_glts_at+tlrc.nii.gz'[2]' \
			s21	Read	-1	"$spath"/sub21/GLM_glts_at+tlrc.nii.gz'[4]' \
			s22	Read	1	"$spath"/sub22/GLM_glts_at+tlrc.nii.gz'[0]' \
			s22	Read	0	"$spath"/sub22/GLM_glts_at+tlrc.nii.gz'[2]' \
			s22	Read	-1	"$spath"/sub22/GLM_glts_at+tlrc.nii.gz'[4]' \
			s23	Read	1	"$spath"/sub23/GLM_glts_at+tlrc.nii.gz'[0]' \
			s23	Read	0	"$spath"/sub23/GLM_glts_at+tlrc.nii.gz'[2]' \
			s23	Read	-1	"$spath"/sub23/GLM_glts_at+tlrc.nii.gz'[4]' \
			s24	Read	1	"$spath"/sub24/GLM_glts_at+tlrc.nii.gz'[0]' \
			s24	Read	0	"$spath"/sub24/GLM_glts_at+tlrc.nii.gz'[2]' \
			s24	Read	-1	"$spath"/sub24/GLM_glts_at+tlrc.nii.gz'[4]' \
			s25	Read	1	"$spath"/sub25/GLM_glts_at+tlrc.nii.gz'[0]' \
			s25	Read	0	"$spath"/sub25/GLM_glts_at+tlrc.nii.gz'[2]' \
			s25	Read	-1	"$spath"/sub25/GLM_glts_at+tlrc.nii.gz'[4]' \
			s26	Read	1	"$spath"/sub26/GLM_glts_at+tlrc.nii.gz'[0]' \
			s26	Read	0	"$spath"/sub26/GLM_glts_at+tlrc.nii.gz'[2]' \
			s26	Read	-1	"$spath"/sub26/GLM_glts_at+tlrc.nii.gz'[4]' \
			s27	Read	1	"$spath"/sub27/GLM_glts_at+tlrc.nii.gz'[0]' \
			s27	Read	0	"$spath"/sub27/GLM_glts_at+tlrc.nii.gz'[2]' \
			s27	Read	-1	"$spath"/sub27/GLM_glts_at+tlrc.nii.gz'[4]' \
			s28	Read	1	"$spath"/sub28/GLM_glts_at+tlrc.nii.gz'[0]' \
			s28	Read	0	"$spath"/sub28/GLM_glts_at+tlrc.nii.gz'[2]' \
			s28	Read	-1	"$spath"/sub28/GLM_glts_at+tlrc.nii.gz'[4]' \
			s29	Read	1	"$spath"/sub29/GLM_glts_at+tlrc.nii.gz'[0]' \
			s29	Read	0	"$spath"/sub29/GLM_glts_at+tlrc.nii.gz'[2]' \
			s29	Read	-1	"$spath"/sub29/GLM_glts_at+tlrc.nii.gz'[4]' \
			s33	Read	1	"$spath"/sub33/GLM_glts_at+tlrc.nii.gz'[0]' \
			s33	Read	0	"$spath"/sub33/GLM_glts_at+tlrc.nii.gz'[2]' \
			s33	Read	-1	"$spath"/sub33/GLM_glts_at+tlrc.nii.gz'[4]' 
end
  
