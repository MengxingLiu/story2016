#!/bin/csh
################## Convert afni volumes to talairach
set spath = "/public/home/max/story2016fMRI/"


set n = 2
while ( $n <= 33 )
	set sub = (sub`count $n $n -digit 2`)
	echo "======================"$sub"=========================="
	cd "$spath"/"$sub"/orig_files
		rm __ats_tmp__ipad+orig.* Anatomical_reg_AlndExp_at* Anatomical_reg_AlndExp_ns_at+tlrc* 
		@auto_tlrc -suffix _ns_at \
			-base TT_N27+tlrc \
			-input Anatomical_reg_AlndExp+orig
		@auto_tlrc -rmode NN -suffix _at \
			-apar Anatomical_reg_AlndExp_ns_at+tlrc \
			-input Anatomical_reg_AlndExp+orig

		3dAFNItoNIFTI -float \
			-prefix Anatomical_reg_AlndExp_ns_at+tlrc.nii.gz \
			Anatomical_reg_AlndExp_ns_at+tlrc.
		3dAFNItoNIFTI -float \
			-prefix Anatomical_reg_AlndExp_at+tlrc.nii.gz \
			Anatomical_reg_AlndExp_at+tlrc.
		set glm = GLM
		set glt = GLM_glts
		
		foreach infile( $glm $glt )
			echo "Working on file: $infile ..."			
		rm "$spath"/"$sub"/"$infile"_at+tlrc*
			@auto_tlrc -rmode NN -dxyz 3 \
					-suffix _at \
					-apar Anatomical_reg_AlndExp_ns_at+tlrc \
					-input "$infile"+orig
			3dAFNItoNIFTI -float -prefix "$infile"_at+tlrc.nii.gz \
					"$infile"_at+tlrc.
		rm "$infile"_at+tlrc.BRIK "$infile"_at+tlrc.HEAD
		end
		mv *_at+tlrc.nii.gz ../
	echo "================Finished: $sub !=============="
@ n++
end

	echo "================Finished: all =============="
