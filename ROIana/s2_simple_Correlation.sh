##################################################################
# Step 2: Compute the simple correlation analysis for each subject
#================================================================
#!/bin/csh
set spath = "/public/home/max/story2016fMRI/"

#=====Here get the ts for each condition
foreach task( listen  read)
    if ($task == "listen") then
        set sublist = ( sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 \
                    sub12 sub13 sub15 sub16 sub31 sub32)
    else 
        set sublist = ( sub10 sub11 sub14 sub17 sub19 sub20 sub21 \
                 sub22 sub23 sub24 sub25 sub26 sub27 sub28 \
                 sub29 sub33)
    endif

    foreach sub( $sublist )
        #mkdir "$spath"/"$sub"/simCorrAna/
        mkdir -p "$spath"/group/func_connect/"$sub"/
        cd "$spath"/group/func_connect/"$sub"/
        rm *
        echo "===========Simple Correlation Analysis for: $sub  ==================="
        set tsfile = "$spath"/"$sub"/map2subAvg/ts.nii
        foreach type( CS US SW NS )
            if $type == CS then
                set columns_01 = {0..19}; set columns_02 = {21..28}
            else if $type == US then
                set columns_01 = {0..20}; set columns_02 = {22..28}
            columns = 0..20 22..28
            else if $type == SW then
                 set columns_01 = {0..21}; set columns_02 = {23..28}
            columns = 0..21 23..28
            else if $type == NS then
                 set columns_01 = {0..19}; set columns_02 = {20..28}
            endif
            rm ts_NoInterest.nii.gz
            3dSynthesize -cbucket "$spath"/"$sub"/map2subAvg/GLM.cbucket.nii.gz \
                -matrix "$spath"/"$sub"/orig_files/GLM.x1D -select \
                $columns_01 $columns_02 \
                -prefix ts_NoInterest.nii.gz
            rm ts_CleanData_All.nii.gz
            3dcalc -prefix ts_CleanData_All.nii.gz \
               -a $tsfile \
               -b ts_NoInterest.nii.gz \
               -expr '(a-b)'
          #     rm "$type"_NoInterest+tlrc.nii.gz
        
         # split the whole time series into 4 ts, for 4 conditions
            3dTcat -prefix ts_CleanData_"$type".nii.gz \
                ts_CleanData_All.nii.gz"[1dcat /public/home/max/scripts/story2016/index_$type.1D]"
           # Here 3dAutomask not worked well no-skulled dataset, so we get it from Anatomical dataset
                #3dAutomask -prefix CleanData_mask CleanData_at+tlrc
                #3dAutomask -prefix CleanData_mask Anatomical_reg_AlndExp_ns_at+tlrc
          # Here Our Dataset are based on skullstripped, so itself can be the mask
            3dmaskave -quiet -mask ts_CleanData_"$type".nii.gz \
                         ts_CleanData_"$type".nii.gz > ts_Global_"$type".1D
            # get time seires of ROI FFG
            3dmaskave -mask "$spath"/group/func_connect/mask/FFG_lh_"$task".nii.gz \
                          ts_CleanData_"$type".nii.gz | awk '{print $1}' \
                          > ts_lh_FFG_"$type".1D
            # get time series of ROI STG
            3dmaskave -mask "$spath"/group/func_connect/mask/lh_STG.nii.gz \
                          ts_CleanData_"$type".nii.gz | awk '{print $1}' \
                          > ts_lh_STG_"$type".1D
            foreach ROIs(FFG STG)
                3dDeconvolve -input ts_CleanData_"$type".nii.gz \
                    -polort A \
                    -num_stimts 2 \
                    -stim_file 1 ts_Global_"$type".1D -stim_label 1 NoInterest \
                    -stim_file 2 ts_lh_"$ROIs"_"$type".1D -stim_label 2 lh_"$ROIs" \
                    -tout -rout \
                    -bucket Corr_lh_"$ROIs"_"$type".nii.gz
                    rm *.REML_cmd
                    rm *.xmat.1D
                    rm *.xsave
                3dcalc -prefix Corr_lh_"$ROIs"_"$type"_R.nii.gz \
                         -a Corr_lh_"$ROIs"_"$type".nii.gz'[7]' \
                         -b Corr_lh_"$ROIs"_"$type".nii.gz'[5]' \
                         -expr "ispositive(b)*sqrt(a)-isnegative(b)*sqrt(a)"
               3dcalc -prefix Corr_lh_"$ROIs"_"$type"_Z.nii.gz \
                         -a Corr_lh_"$ROIs"_"$type"_R.nii.gz \
                         -expr 'log((1+a)/(1-a))/2'
               rm Corr_lh_"$ROIs"_"$type"_R.nii.gz
            end
        end
    end
end
echo "===================Finished!==================="

