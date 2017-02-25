#!/bin/csh
################################################################################
#########      Pre-processing
##############################################################################

set spath="/media/max/Mengxing/story2016fMRI"

#if $#argv != 1 then
#	echo "Usage: csh preprossing.sh [SubjDirectory]"
#	echo "Please specific the subjects' folder"
#else
#	set sub = $argv[1]

foreach sub(sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 sub10 sub11 sub12 sub13 sub14 sub15 sub16 sub17 sub18 sub19 sub20 sub21 sub22 sub23 sub24 sub25 sub26 sub27 sub28 sub29 sub30 sub31 sub32 sub33)
#foreach sub(sub21)
	cd "$spath"/"$sub"/orig_files

		echo "##################################################"
		echo "---------------------$sub-------------------------"
		echo "##################################################"
	########################## Relignment T1 according EPI dataset
	# TRs in run: 179 169 172 187 181	
	#foreach run(run01 run02 run03 run04 run05 run06)
	rm motion* *reg* *deob* Dis* ts* Tshift*
		3dTcat -prefix Dis_run01+orig  run01+orig\[6..184]
		3dTcat -prefix Dis_run02+orig  run02+orig\[6..174]
		3dTcat -prefix Dis_run03+orig  run03+orig\[6..177]
		3dTcat -prefix Dis_run04+orig  run04+orig\[6..192]
		3dTcat -prefix Dis_run05+orig  run05+orig\[6..186]
		
	#end
			
			
			# Transform obliqued dataset
	3dWarp -deoblique \
               -prefix Anatomical_deob \
               -gridset Anatomical+orig. \
               Anatomical+orig.

	foreach run(run01 run02 run03 run04 run05)
          3dWarp -deoblique \
               -prefix "$run"_deob \
               -gridset Dis_"$run"+orig. \
               Dis_"$run"+orig.
               
	end
	
	foreach run(run01 run02 run03 run04 run05)
		####################### Time correction
		3dTshift -verbose \
			-tpattern @"$spath"/scripts/ftpattern \
			-prefix Tshift_"$run" \
			"$run"_deob+orig
#		 rm "$run"_deob+ori*
    end

	# Get the mean sub-brick of the middle run
	3dTstat -mean -prefix mean_run03 Tshift_run03+orig
	
	# Align the T1 accroding EPI dataset (mean of the Middle run) 
	align_epi_anat.py -partial_coverage \
		-anat Anatomical_deob+orig \
		-epi mean_run03+orig \
		-epi_base 0
	
	# register volume
	3dAllineate -float -prefix Anatomical_reg \
		-cubic -1Dmatrix_apply Anatomical_deob_al_mat.aff12.1D \
		Anatomical_deob+orig
	 rm _lpc*
	 rm anat2epi.aff12.1D

	
	foreach run(run01 run02 run03 run04 run05)
		####################### Motion correction
		3dvolreg -prefix reg_"$run" \
			-float -twopass -twodup \
			-1Dfile motion_"$run" \
			-base mean_run03+orig \
			Tshift_"$run"+orig
#		 rm Tshift_"$run"+orig*
		
		######################## despike data
		3dDespike -prefix despike_reg_"$run" \
			reg_"$run"+orig
#		 rm reg_"$run"+orig*
	end
	
	#########Normalized the dataset ####################################	
	###############################Get the clip value for all EPI dataset
	set clip=99999
	foreach run(run01 run02 run03 run04 run05)
		set cur = `3dClipLevel  despike_reg_"$run"+orig.`
   		if (`echo "$cur < $clip"|bc`) then
   			set clip = "$cur"
   		endif 
	end

	foreach run(run01 run02 run03 run04 run05)
		######################## signal change %
		3dTstat -prefix mean_despike_reg_"$run" \
			-mean despike_reg_"$run"+orig
	
		3dcalc -prefix norm_despike_reg_"$run" \
			-a despike_reg_"$run"+orig \
			-b mean_despike_reg_"$run"+orig \
			-datum float -expr "((a-b)/b)*100*step(b-$clip)"
			
#		rm despike_reg_"$run"+orig*
#		rm mean_despike_reg_"$run"+orig*
		
		######################## detrend timeseries
		#3dDetrend -prefix detrend_despike_reg_"$run" \
		#	-vector motion_"$run" -polort A \
		#	norm_despike_reg_"$run"+orig
			
		3dDetrend -prefix normalized_detrend_despike_reg_"$run" \
			-normalize -vector motion_"$run" -polort A \
			norm_despike_reg_"$run"+orig
#		rm norm_despike_reg_"$run"+orig*
	end

	#######################################
	# make a mask without skull of Anatomical
	3dSkullStrip -prefix Anatomical_reg_noskull \
		-input Anatomical_reg+orig 
	
	3dcalc -prefix Anatomical_reg_noskull_mask \
		-a Anatomical_reg_noskull+orig \
		-expr 'step(a)'

#	rm Anatomical_reg_noskull+orig*
	
	3dresample -prefix Anatomical_reg_noskull_mask_resample \
		-rmode Li \
		-master mean_run03+orig \
		-inset Anatomical_reg_noskull_mask+orig
#	rm Anatomical_reg_noskull_mask+orig*
	
	#noskull mask from EPI dataset
	3dAutomask -prefix noskull_mean_run03 mean_run03+orig
	
	3dcalc -prefix noskull_mask \
		-a noskull_mean_run03+orig \
		-b Anatomical_reg_noskull_mask_resample+orig \
		-expr 'step(a+b)'
#	rm Anatomical_reg_noskull_mask_resample+orig*

	######################Get the noskulled EPI dataset
	foreach run(run01 run02 run03 run04 run05)
		3dcalc -prefix mask_normalized_detrend_despike_reg_"$run" \
			-a noskull_mask+orig \
			-b normalized_detrend_despike_reg_"$run"+orig \
			-float -expr 'b*step(a)'
		#rm normalized_detrend_despike_reg_"$run"+orig*

		
	end

#	rm mean_run03+orig*
#	rm noskull_mean_run03+orig*
#	rm noskull_mask+orig*
 
	##########################################################
	# concatenate timeseries



	3dTcat -prefix ts_normalized \
			mask_normalized_detrend_despike_reg_run01+orig \
			mask_normalized_detrend_despike_reg_run02+orig \
			mask_normalized_detrend_despike_reg_run03+orig \
			mask_normalized_detrend_despike_reg_run04+orig \
			mask_normalized_detrend_despike_reg_run05+orig 
			
			
	cat \
		motion_run01 \
		motion_run02 \
		motion_run03 \
		motion_run04 \
		motion_run05 \
		> motion.1D

	
#endif

		echo "##################################################"
		echo "================finished $sub ===================="
		echo "##################################################"
	set overtime = (date -u +%s)
#	set tdiff = `expr $starttime - $overtime`
		echo "##################################################"
#		echo "$(($tdiff / 60) ) minutes elapsed for $sub."		
		echo "##################################################"

end


