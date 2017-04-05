#!/bin/csh

# select ROIs

# ATL 568     Insula 574+576+385   aIFG 377+379    pIFG 597
# AG 605+547 pMTG 604    SPS 584+587
# temporal cortex 605 557 604 556
# AG 547
set spath = /public/home/max/story2016fMRI
set maskpath =  /public/home/max/story2016fMRI/group/anat_ROIs
set ROIanapath =  /public/home/max/story2016fMRI/group/ROI_ana
cd $maskpath
 
foreach h(lh rh)
    rm "$h"_temporal.nii.gz
    3dcalc -a ROIs_"$h".nii.gz \
        -expr "or(equals(a,605),equals(a,557),equals(a,604),equals(a,556),equals(a,568))" \
        -prefix "$h"_temporal.nii.gz
end
foreach type("STG 605" "ATL 568" "pMTG 604" "pIFG 597" "AG_2 547")
    set ROI = (`echo $type | awk '{print $1}'`)
    set n = (`echo $type | awk '{print $2}'`)
    foreach h(lh rh)
        rm "$h"_"$ROI".nii.gz
        3dcalc -a ROIs_"$h".nii.gz \
                -expr "step(equals(a,$n))" \
                -prefix "$h"_"$ROI".nii.gz
    end
end

foreach type("aIFG 377 379" "AG 605 547" "SPS 584 587")
    set ROI = (`echo $type | awk '{print $1}'`)
    set n = (`echo $type | awk '{print $2}'`)
    set m = (`echo $type | awk '{print $3}'`)
    foreach h(lh rh)
        rm "$h"_"$ROI".nii.gz
        3dcalc -a ROIs_"$h".nii.gz \
            -expr "step(equals(a,$n)+equals(a,$m))" \
            -prefix "$h"_"$ROI".nii.gz
    end
end

foreach type("Insula 574 576 385")
    set ROI = (`echo $type | awk '{print $1}'`)
    set n = (`echo $type | awk '{print $2}'`)
    set m = (`echo $type | awk '{print $3}'`)
    set t = (`echo $type | awk '{print $4}'`)

    foreach h(lh rh)
        rm "$h"_"$ROI".nii.gz
        3dcalc -a ROIs_"$h".nii.gz \
            -expr "step(equals(a,$n)+equals(a,$m)+equals(a,$t))" \
            -prefix "$h"_"$ROI".nii.gz
    end
end

# constrain pMTG in 28<y<52  and -9<z<1
    rm lh_pMTG_small.nii.gz
    3dcalc -prefix lh_pMTG_small.nii.gz \
            -a lh_pMTG.nii.gz \
            -expr 'a*step(144-(y-40)*(y-40))*step(64-(z+7)*(z+7))'
# constrain STG in  7<y<43
    rm lh_STG_small.nii.gz
    3dcalc -prefix lh_STG_small.nii.gz \
            -a lh_STG.nii.gz \
            -expr 'a*step(324-(y-25)*(y-25))'
# select anterior temporal cortex  y<1
    rm lh_aT.nii.gz
    3dcalc -prefix lh_aT.nii.gz \
        -a lh_temporal.nii.gz \
        -expr "a*step(1-y)" 
# select middle temporal cortex 15<y<24
    rm lh_mT.nii.gz
    3dcalc -prefix lh_mT.nii.gz \
        -a lh_temporal.nii.gz \
        -expr "a*step(y-15)*step(34-y)"
# select posterior temporal cortex 49<y<61
    rm lh_pT.nii.gz 
    3dcalc -prefix lh_pT.nii.gz \
        -a lh_temporal.nii.gz \
        -expr "a*step(y-49)*step(61-y)"
foreach task (listen read)
     if ($task == "listen") then
        set sublist = ( sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 \
                    sub12 sub13 sub15 sub16 sub31 sub32)
    else
        set sublist = ( sub10 sub11 sub14 sub17 sub19 sub20 sub21 \
                 sub22 sub23 sub24 sub25 sub26 sub27 sub28 \
                 sub29 sub33)
    endif
    foreach ROI(aIFG pIFG FFG Insula SPS aT mT pT)
        echo "#subj CS US SW" > "$ROIanapath"/"$task"_"$ROI".1D
        foreach sub( $sublist )
            3dmaskave -mask "$maskpath"/lh_"$ROI".nii.gz \
                "$spath"/"$sub"/map2subAvg/GLM_glts.nii.gz\[0,2,4] \
                | dm x1 | transpose > temp_beta.tmp
            echo $sub `cat temp_beta.tmp` >> "$ROIanapath"/"$task"_$ROI.1D
            rm temp_beta.tmp
        end
    end
end
cd "$ROIanapath"
foreach task (listen read )
    echo  "KEY CS US SW" > summary_"$task".txt
    foreach ROI(aIFG pIFG FFG Insula SPS aT mT pT)
        set m1 = (`cat "$task"_"$ROI".1D | tail -16 | dm x2 | stats | grep mean | awk '{printf("%.5f",$3)}'`)
        set m2 = (`cat "$task"_"$ROI".1D | tail -16 | dm x3 | stats | grep mean | awk '{printf("%.5f",$3)}'`)
        set m3 = (`cat "$task"_"$ROI".1D | tail -16 | dm x4 | stats | grep mean | awk '{printf("%.5f",$3)}'`)
        set s1 = (`cat "$task"_"$ROI".1D | tail -16 | dm x2 | stats | grep se | awk '{printf("%.5f",$3)}'`)
        set s2 = (`cat "$task"_"$ROI".1D | tail -16 | dm x3 | stats | grep se | awk '{printf("%.5f",$3)}'`)
        set s3 = (`cat "$task"_"$ROI".1D | tail -16 | dm x4 | stats | grep se | awk '{printf("%.5f",$3)}'`)
        echo $ROI "$m1($s1)" "$m2($s2)" "$m3($s3)" >> summary_"$task".txt
    end
end
#######################################################################
## step 7: Plot out the betas values for conditions across two Tasks
#======================================================================
foreach ROI(aIFG pIFG FFG Insula SPS aT mT pT)
    echo KEY listen read > head.tmp
    echo "CS US SW" | transpose > key.tmp
    foreach task(listen read) 
        cat summary_"$task".txt | grep "$ROI" \
            | dm s2 s3 s4 | transpose > "$task".tmp
    end
    abut key.tmp listen.tmp read.tmp > temp.tmp
    cat head.tmp temp.tmp | graf -font Arial -fontsize 18 -width 3.6 \
                            -height 3.6 -linewidth 1 -ymax 0.06 -ymin 0.00 \
                            -num_major_yticks 3 -num_minor_yticks 1 \
                            -errbarwidth 0.6 -barborderthickness 1 \
                            -color0 white \
        > fig_"$ROI".eps
end




