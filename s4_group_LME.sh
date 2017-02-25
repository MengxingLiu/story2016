#!/bin/csh
#this script do linear trend.
# code "condition" as a quantitative variable
# reference: https://afni.nimh.nih.gov/afni/community/board/read.php?1,149234,153119#msg-153119
# set CS=1 US=0 SW=-1
set spath="/public/home/max/story2016fMRI"
# rm -rf $spath/group/surface_files
cd $spath/group/surface_files/
################ group level statistic #################
    foreach hemi(lh)
	3dLME -prefix "$hemi"_group_LME.1D -jobs 12 \
			-model "Modality*Scale" \
			-qVars "Scale" -ranEff '~Scale' \
			-num_glt 2 \
			-gltLabel 1 LTrend -gltCode 1 'Modality : 1*Listen Scale : ' \
			-gltLabel 2 RTrend -gltCode 2 'Modality : 1*Read Scale : ' \
			-dataTable \
			Subj	Modality	Scale	InputFile \
			s2	Listen	5	"$spath"/sub02/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s2	Listen	3	"$spath"/sub02/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s2	Listen	1	"$spath"/sub02/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s3	Listen	5	"$spath"/sub03/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s3	Listen	3	"$spath"/sub03/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s3	Listen	1	"$spath"/sub03/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s4	Listen	5	"$spath"/sub04/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s4	Listen	3	"$spath"/sub04/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s4	Listen	1	"$spath"/sub04/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s5	Listen	5	"$spath"/sub05/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s5	Listen	3	"$spath"/sub05/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s5	Listen	1	"$spath"/sub05/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s6	Listen	5	"$spath"/sub06/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s6	Listen	3	"$spath"/sub06/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s6	Listen	1	"$spath"/sub06/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s7	Listen	5	"$spath"/sub07/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s7	Listen	3	"$spath"/sub07/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s7	Listen	1	"$spath"/sub07/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s8	Listen	5	"$spath"/sub08/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s8	Listen	3	"$spath"/sub08/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s8	Listen	1	"$spath"/sub08/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s9	Listen	5	"$spath"/sub09/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s9	Listen	3	"$spath"/sub09/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s9	Listen	1	"$spath"/sub09/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s12	Listen	5	"$spath"/sub12/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s12	Listen	3	"$spath"/sub12/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s12	Listen	1	"$spath"/sub12/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s13	Listen	5	"$spath"/sub13/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s13	Listen	3	"$spath"/sub13/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s13	Listen	1	"$spath"/sub13/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s15	Listen	5	"$spath"/sub15/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s15	Listen	3	"$spath"/sub15/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s15	Listen	1	"$spath"/sub15/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s16	Listen	5	"$spath"/sub16/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s16	Listen	3	"$spath"/sub16/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s16	Listen	1	"$spath"/sub16/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s31	Listen	5	"$spath"/sub31/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s31	Listen	3	"$spath"/sub31/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s31	Listen	1	"$spath"/sub31/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s32	Listen	5	"$spath"/sub32/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s32	Listen	3	"$spath"/sub32/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s32	Listen	1	"$spath"/sub32/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s10	Read	5	"$spath"/sub10/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s10	Read	3	"$spath"/sub10/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s10	Read	1	"$spath"/sub10/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s11	Read	5	"$spath"/sub11/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s11	Read	3	"$spath"/sub11/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s11	Read	1	"$spath"/sub11/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s14	Read	5	"$spath"/sub14/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s14	Read	3	"$spath"/sub14/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s14	Read	1	"$spath"/sub14/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s17	Read	5	"$spath"/sub17/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s17	Read	3	"$spath"/sub17/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s17	Read	1	"$spath"/sub17/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s19	Read	5	"$spath"/sub19/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s19	Read	3	"$spath"/sub19/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s19	Read	1	"$spath"/sub19/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s20	Read	5	"$spath"/sub20/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s20	Read	3	"$spath"/sub20/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s20	Read	1	"$spath"/sub20/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s21	Read	5	"$spath"/sub21/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s21	Read	3	"$spath"/sub21/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s21	Read	1	"$spath"/sub21/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s22	Read	5	"$spath"/sub22/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s22	Read	3	"$spath"/sub22/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s22	Read	1	"$spath"/sub22/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s23	Read	5	"$spath"/sub23/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s23	Read	3	"$spath"/sub23/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s23	Read	1	"$spath"/sub23/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s24	Read	5	"$spath"/sub24/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s24	Read	3	"$spath"/sub24/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s24	Read	1	"$spath"/sub24/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s25	Read	5	"$spath"/sub25/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s25	Read	3	"$spath"/sub25/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s25	Read	1	"$spath"/sub25/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s26	Read	5	"$spath"/sub26/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s26	Read	3	"$spath"/sub26/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s26	Read	1	"$spath"/sub26/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s27	Read	5	"$spath"/sub27/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s27	Read	3	"$spath"/sub27/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s27	Read	1	"$spath"/sub27/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s28	Read	5	"$spath"/sub28/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s28	Read	3	"$spath"/sub28/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s28	Read	1	"$spath"/sub28/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s29	Read	5	"$spath"/sub29/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s29	Read	3	"$spath"/sub29/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s29	Read	1	"$spath"/sub29/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s33	Read	5	"$spath"/sub33/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s33	Read	3	"$spath"/sub33/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s33	Read	1	"$spath"/sub33/surface_files/"$hemi"_GLM_glts.1D'[10]' 
end
#provide an index column for the results for 3dSurf2Vol
foreach hemi(lh)
	1dcat "$spath"/sub02/surface_files/"$hemi"_GLM_glts.1D'[0]' \
		"$hemi"_group_LME.1D \
		>> "$hemi"_group_LME.dset
end
#put group results back into volume world
foreach hemi(lh)
#			rm "$hemi"_group_LME.dset
			3dSurf2Vol \
				-spec "$spath"/group/freesurfer/SUMA/subAvg_"$hemi"+tlrc.spec \
				-surf_A smoothwm \
				-surf_B pial \
				-sv ../subAvg_SurfVol_at+tlrc.nii.gz \
				-grid_parent "$spath"/sub02/GLM_glts_at+tlrc.nii.gz \
				-sdata_1D "$hemi"_group_LME.dset \
				-datum float \
				-map_func max_abs \
				-f_steps 15 \
				-f_index voxels \
				-f_p1_fr -0.2 -f_pn_fr 0.4 \
				-prefix ./"$hemi"_group_LME_sb
			bzip2 "$hemi"_group_LME.dset
		end
rm group_LME.nii.gz
3dcalc \
	-float \
	-a lh_group_LME_sb+tlrc. \
	-b rh_group_LME_sb+tlrc. \
	-expr '(a+b)' \
	-prefix group_LME.nii.gz 
   
