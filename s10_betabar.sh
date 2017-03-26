####################################################################
# Step 1: Get signal % from IRESP for each participant
#==========================================================
#!/bin/csh
set spath = "/Users/jfyang/projects/task_VWFA/analysis"
     foreach sub(sub01 sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 sub10 sub11 sub12 sub13 sub14 sub15 sub16)
          cd "$spath"/"$sub"/map2subAvg/
          foreach task(LD SD)
               3dTcat -prefix signal_"$task"+tlrc.nii.gz \
                    iresp_"$task"_RW+tlrc.nii.gz\[5] \
                    iresp_"$task"_PS+tlrc.nii.gz\[5] \
                    iresp_"$task"_OS+tlrc.nii.gz\[5] \
                    iresp_"$task"_OO+tlrc.nii.gz\[5] \
                    iresp_"$task"_RR+tlrc.nii.gz\[5] \
                    iresp_"$task"_NN+tlrc.nii.gz\[5]
          end
     end

####################################################################
# Step 2: Get signal % for ANOVA analysis
#==========================================================
#!/bin/csh
set spath = "/Users/jfyang/projects/task_VWFA/analysis"

cd "$spath"/group/ICA/ICA_2task/anova_ICs/ICs_correlated/
     mkdir signal/
     foreach IC(`ls mask/ | dm s1 | sed -e s/'\.'/' '/ | awk '{print $1}'`)
          echo "#subj task cond signal" > signal/"$IC".1D
          foreach task(LD SD)
               foreach sub(sub01 sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 sub10 sub11 sub12 sub13 sub14 sub15 sub16)
                     3dmaskave -mask mask/"$IC".nii.gz \
                          "$spath"/"$sub"/map2subAvg/signal_"$task"+tlrc.nii.gz\[0,1,2,3,4,5] | dm x1 > temp_beta.tmp
                     foreach cond(RW PS OS OO RR NN)
                         echo $sub $task $cond >> temp_head.tmp
                    end
                    abut temp_head.tmp temp_beta.tmp >> signal/"$IC".1D
                    rm *.tmp
                end
          end
     end

####################################################################
# Step 3: ANOVA analysis on each correlated IC's beta values
#==========================================================
set spath = "/Users/jfyang/projects/task_VWFA/analysis"

cd "$spath"/group/ICA/ICA_2task/anova_ICs/ICs_correlated/
     echo "ICs Task Cond TxC" > signal_anovaP.1D
     foreach IC(`ls signal/ | dm s1 | sed -e s/'\.'/' '/ | awk '{print $1}'`)
          set p_Task  = (`cat signal/"$IC".1D | grep -v "#" | anova Subj Task Cond beta | tail -9 | head -1 | dm s6`)
          set p_Cond = (`cat signal/"$IC".1D | grep -v "#" | anova Subj Task Cond beta | tail -6 | head -1 | dm s6`)
          set p_TxC   = (`cat signal/"$IC".1D | grep -v "#" | anova Subj Task Cond beta | tail -3 | head -1 | dm s6`)
          echo $IC $p_Task $p_Cond $p_TxC >> signal_anovaP.1D
     end

#####################################################################
## Step 4: Get the mask for ICs showed high significant ANOVA effects
#==============================================================
set spath = "/Users/jfyang/projects/task_VWFA/analysis/group/ICA/ICA_2task"
mkdir "$spath"/anova_ICs/plotSignal_anovaICs/
cd "$spath"/anova_ICs/plotSignal_anovaICs/
     mkdir mask_ICs
     mkdir mask_ROIs
     foreach IC(`cat ICs_list.txt | grep -v '#'`)
          cp "$spath"/result_ICA/mask_ICs/"$IC".nii.gz mask_ICs/
          cp "$spath"/result_ICA/mask_ROIs/"$IC"* mask_ROIs/
     end

#####################################################################
## Step 5: Get Signal % for each IC/ROI had significant effect
#==============================================================
set spath = "/Users/jfyang/projects/task_VWFA/analysis"
cd "$spath"/group/ICA/ICA_2task/anova_ICs/plotSignal_anovaICs/
     set type = "_ICs" # "_ROIs"
     mkdir Signal"$type"/
     foreach ROI(`ls mask"$type" | dm s1 | sed -e s/'\.'/' '/ | awk '{print $1}'`)
          foreach task(LD SD)
               echo "#subj RW PS OS OO RR NN" > Signal"$type"/"$task"_"$ROI".1D
               foreach sub(sub01 sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 sub10 sub11 sub12 sub13 sub14 sub15 sub16)
                     3dmaskave -mask mask"$type"/"$ROI".nii.gz \
                          "$spath"/"$sub"/map2subAvg/Signal_"$task"+tlrc.nii.gz\[0,1,2,3,4,5] \
                          | dm x1 | transpose > temp_beta.tmp
                         echo $sub `cat temp_beta.tmp` >> Signal"$type"/"$task"_"$ROI".1D
                         rm temp_beta.tmp
                end
          end
     end

####################################################################
# Step 6: Summary the beta values of each IC/ROI to plot the bar figures
#================================================================
set spath = "/Users/jfyang/projects/task_VWFA/analysis"
cd "$spath"/group/ICA/ICA_2task/anova_ICs/plotSignal_anovaICs/
     set type = "_ICs"      #"_ROIs"
     foreach task(LD SD)
          echo "KEY RW PS OS OO RR NN RW PW NW" > Signal"$type"/summary_"$task".txt
          foreach ROI(`ls mask"$type" | dm s1 | sed -e s/'\.'/' '/ | awk '{print $1}'`)
               set m1=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x2 | stats | grep mean | awk '{printf("%.5f",$3)}'`)
               set m2=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x3 | stats | grep mean | awk '{printf("%.5f",$3)}'`)
               set m3=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x4 | stats | grep mean | awk '{printf("%.5f",$3)}'`)
               set m4=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x5 | stats | grep mean | awk '{printf("%.5f",$3)}'`)
               set m5=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x6 | stats | grep mean | awk '{printf("%.5f",$3)}'`)
               set m6=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x7 | stats | grep mean | awk '{printf("%.5f",$3)}'`)
               set m7=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x2 | stats | grep mean | awk '{printf("%.5f",$3)}'`)
               set m8=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x3+x4+x5 | dm x1/3 | stats | grep mean | awk '{printf("%.5f",$3)}'`)
               set m9=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x6+x7 | dm x1/2 | stats | grep mean | awk '{printf("%.5f",$3)}'`)

               set s1=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x2 | stats | grep se | awk '{printf("%.5f",$3)}'`)
               set s2=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x3 | stats | grep se | awk '{printf("%.5f",$3)}'`)
               set s3=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x4 | stats | grep se | awk '{printf("%.5f",$3)}'`)
               set s4=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x5 | stats | grep se | awk '{printf("%.5f",$3)}'`)
               set s5=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x6 | stats | grep se | awk '{printf("%.5f",$3)}'`)
               set s6=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x7 | stats | grep se | awk '{printf("%.5f",$3)}'`)
               set s7=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x2 | stats | grep se | awk '{printf("%.5f",$3)}'`)
               set s8=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x3+x4+x5 | dm x1/3 | stats | grep se | awk '{printf("%.5f",$3)}'`)
               set s9=(`cat Signal"$type"/"$task"_"$ROI".1D | tail -16 | dm x6+x7 | dm x1/2 | stats | grep se | awk '{printf("%.5f",$3)}'`)

               echo $ROI "$m1($s1)" "$m2($s2)" "$m3($s3)" "$m4($s4)" "$m5($s5)" "$m6($s6)" \
                          "$m7($s7)" "$m8($s8)" "$m9($s9)" >> Signal"$type"/summary_"$task".txt
          end
     end

#######################################################################
## Step 7: Plot out the betas values for conditions across two Tasks
#================================================================
set spath = "/Users/jfyang/projects/task_VWFA/analysis"
cd "$spath"/group/ICA/ICA_2task/anova_ICs/plotSignal_anovaICs/
     foreach type( _ICs _ROIs)
          mkdir fig_task"$type"/
          foreach ROI(`ls mask"$type" | dm s1 | sed -e s/'\.'/' '/ | awk '{print $1}'`)
               echo KEY LD SD > head.tmp
               echo "RW PS OS OO RR NN" | transpose > key.tmp
               foreach task(LD SD)
                    cat Signal"$type"/summary_"$task".txt | grep "$ROI" | dm s2 s3 s4 s5 s6 s7 | transpose > "$task".tmp
               end
               abut key.tmp LD.tmp SD.tmp > temp.tmp
               cat head.tmp temp.tmp | graf -font Arial -fontsize 18 -width 3.6 -height 3.6 -linewidth 1 \
                         -ymax 0.06 -ymin 0.00 -num_major_yticks 3 -num_minor_yticks 1 \
                          -errbarwidth 0.6 -barborderthickness 1 -color0 white \
                         > fig_task"$type"/"$ROI".eps
          end
     end
     rm *.tmp
