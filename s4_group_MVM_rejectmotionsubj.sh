#!/bin/csh

set spath="/public/home/max/story2016fMRI"
# rm -rf $spath/group/surface_files
cd $spath/group/surface_files/
################ group level statistic #################
    foreach hemi(lh rh)

	3dMVM -prefix "$hemi"_group_MVM_reject.1D -jobs 12 \
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
			s2	Listen	CS	"$spath"/sub02/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s2	Listen	US	"$spath"/sub02/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s2	Listen	SW	"$spath"/sub02/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s4	Listen	CS	"$spath"/sub04/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s4	Listen	US	"$spath"/sub04/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s4	Listen	SW	"$spath"/sub04/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s5	Listen	CS	"$spath"/sub05/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s5	Listen	US	"$spath"/sub05/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s5	Listen	SW	"$spath"/sub05/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s6	Listen	CS	"$spath"/sub06/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s6	Listen	US	"$spath"/sub06/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s6	Listen	SW	"$spath"/sub06/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s7	Listen	CS	"$spath"/sub07/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s7	Listen	US	"$spath"/sub07/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s7	Listen	SW	"$spath"/sub07/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s8	Listen	CS	"$spath"/sub08/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s8	Listen	US	"$spath"/sub08/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s8	Listen	SW	"$spath"/sub08/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s9	Listen	CS	"$spath"/sub09/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s9	Listen	US	"$spath"/sub09/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s9	Listen	SW	"$spath"/sub09/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s12	Listen	CS	"$spath"/sub12/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s12	Listen	US	"$spath"/sub12/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s12	Listen	SW	"$spath"/sub12/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s13	Listen	CS	"$spath"/sub13/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s13	Listen	US	"$spath"/sub13/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s13	Listen	SW	"$spath"/sub13/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s15	Listen	CS	"$spath"/sub15/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s15	Listen	US	"$spath"/sub15/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s15	Listen	SW	"$spath"/sub15/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s16	Listen	CS	"$spath"/sub16/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s16	Listen	US	"$spath"/sub16/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s16	Listen	SW	"$spath"/sub16/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s31	Listen	CS	"$spath"/sub31/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s31	Listen	US	"$spath"/sub31/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s31	Listen	SW	"$spath"/sub31/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s32	Listen	CS	"$spath"/sub32/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s32	Listen	US	"$spath"/sub32/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s32	Listen	SW	"$spath"/sub32/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s10	Read	CS	"$spath"/sub10/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s10	Read	US	"$spath"/sub10/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s10	Read	SW	"$spath"/sub10/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s11	Read	CS	"$spath"/sub11/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s11	Read	US	"$spath"/sub11/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s11	Read	SW	"$spath"/sub11/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s14	Read	CS	"$spath"/sub14/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s14	Read	US	"$spath"/sub14/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s14	Read	SW	"$spath"/sub14/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s17	Read	CS	"$spath"/sub17/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s17	Read	US	"$spath"/sub17/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s17	Read	SW	"$spath"/sub17/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s19	Read	CS	"$spath"/sub19/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s19	Read	US	"$spath"/sub19/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s19	Read	SW	"$spath"/sub19/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s20	Read	CS	"$spath"/sub20/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s20	Read	US	"$spath"/sub20/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s20	Read	SW	"$spath"/sub20/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s22	Read	CS	"$spath"/sub22/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s22	Read	US	"$spath"/sub22/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s22	Read	SW	"$spath"/sub22/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s23	Read	CS	"$spath"/sub23/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s23	Read	US	"$spath"/sub23/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s23	Read	SW	"$spath"/sub23/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s24	Read	CS	"$spath"/sub24/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s24	Read	US	"$spath"/sub24/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s24	Read	SW	"$spath"/sub24/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s25	Read	CS	"$spath"/sub25/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s25	Read	US	"$spath"/sub25/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s25	Read	SW	"$spath"/sub25/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s26	Read	CS	"$spath"/sub26/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s26	Read	US	"$spath"/sub26/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s26	Read	SW	"$spath"/sub26/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s27	Read	CS	"$spath"/sub27/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s27	Read	US	"$spath"/sub27/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s27	Read	SW	"$spath"/sub27/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s28	Read	CS	"$spath"/sub28/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s28	Read	US	"$spath"/sub28/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s28	Read	SW	"$spath"/sub28/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s29	Read	CS	"$spath"/sub29/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s29	Read	US	"$spath"/sub29/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s29	Read	SW	"$spath"/sub29/surface_files/"$hemi"_GLM_glts.1D'[10]' \
			s33	Read	CS	"$spath"/sub33/surface_files/"$hemi"_GLM_glts.1D'[6]' \
			s33	Read	US	"$spath"/sub33/surface_files/"$hemi"_GLM_glts.1D'[8]' \
			s33	Read	SW	"$spath"/sub33/surface_files/"$hemi"_GLM_glts.1D'[10]' 
end
#provide an index column for the results for 3dSurf2Vol
foreach hemi(lh rh)
	1dcat "$spath"/sub02/surface_files/"$hemi"_GLM_glts.1D'[0]' \
		"$hemi"_group_MVM_reject.1D \
		>> "$hemi"_group_MVM_reject.dset
end
#put group results back into volume world
foreach hemi(lh rh)
#			rm "$hemi"_group_MVM.dset
			3dSurf2Vol \
				-spec "$spath"/group/freesurfer/SUMA/subAvg_"$hemi"+tlrc.spec \
				-surf_A smoothwm \
				-surf_B pial \
				-sv ../subAvg_SurfVol_at+tlrc.nii.gz \
				-grid_parent "$spath"/sub02/GLM_glts_at+tlrc.nii.gz \
				-sdata_1D "$hemi"_group_MVM_reject.dset \
				-datum float \
				-map_func max_abs \
				-f_steps 15 \
				-f_index voxels \
				-f_p1_fr -0.2 -f_pn_fr 0.4 \
				-prefix ./"$hemi"_group_MVM_reject_sb
			bzip2 "$hemi"_group_MVM_reject.dset
		end
3dcalc \
	-float \
	-a lh_group_MVM_reject_sb+tlrc. \
	-b rh_group_MVM_reject_sb+tlrc. \
	-expr '(a+b)' \
	-prefix group_MVM_rejectmotionsub+tlrc.nii.gz 
   
