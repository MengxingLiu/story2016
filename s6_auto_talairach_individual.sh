#!/bin/csh
################## Convert afni volumes to talairach
set spath = "/public/home/max/story2016fMRI/"


set n = 2 
while ( $n <= 33 )
	set sub = (sub`count $n $n -digit 2`)
	echo "======================"$sub"=========================="
	cd "$spath"/"$sub"/orig_files
#                rm Anatomical_reg_AlndExp_ns+orig.*
#                3dSkullStrip -input ./Anatomical_reg_AlndExp+orig -prefix Anatomical_reg_AlndExp_ns
#		@auto_tlrc -suffix _ns_at \
#			-base TT_N27+tlrc \
#			-input Anatomical_reg_AlndExp+orig
#		@auto_tlrc -rmode NN -suffix _at \
#			-apar Anatomical_reg_AlndExp_ns_at+tlrc \
#			-input Anatomical_reg_AlndExp+orig
#
#		3dAFNItoNIFTI -float \
#			-prefix Anatomical_reg_AlndExp_ns_at+tlrc.nii.gz \
#			Anatomical_reg_AlndExp_ns_at+tlrc.
#		3dAFNItoNIFTI -float \
#			-prefix Anatomical_reg_AlndExp_at+tlrc.nii.gz \
#			Anatomical_reg_AlndExp_at+tlrc.
#	set glm = GLM
	#	set glt = GLM_glts
		
		foreach infile( GLM_glts GLM.cbucket)
			echo "Working on file: $infile ..."			
		rm "$spath"/"$sub"/"$infile"_at+tlrc*
			@auto_tlrc -rmode NN -dxyz 3 \
					-suffix _at \
					-apar ../Anatomical_reg_AlndExp_ns_at+tlrc.nii.gz \
					-input "$infile"+orig
			3dAFNItoNIFTI -float -prefix "$infile"_at+tlrc.nii.gz \
					"$infile"_at+tlrc.
		irm "$infile"_at+tlrc.BRIK "$infile"_at+tlrc.HEAD
		end
	mv *_at+tlrc.nii.gz ../
	echo "================Finished: $sub !=============="
@ n++
end

	echo "================Finished: all =============="
