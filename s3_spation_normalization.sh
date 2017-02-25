#!/bin/csh

set spath="/public/home/max/story2016fMRI"

foreach sub(sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 sub10 sub11 sub12 sub13 sub14 sub15 sub16 sub17 sub18 sub19 sub20 sub21 sub22 sub23 sub24 sub25 sub26 sub27 sub28 sub29 sub30 sub31 sub32 sub33)

	cd "$spath"/"$sub"/orig_files

		echo "##################################################"
		echo "---------------------$sub-------------------------"
		echo "##################################################"
#	@auto_tlrc -base TT_N27+tlrc -input Anatomical_reg+orig \
#				-suffix _norm	
	@auto_tlrc -apar Anatomical_reg_norm+tlrc -input GLM_2_glts+orig -dxyz 3 -rmode NN -suffix _at
			echo "##################################################"
		echo "================finished $sub ===================="
		echo "##################################################"
end


