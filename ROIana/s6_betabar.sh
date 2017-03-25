#!/bin/csh

# select ROIs

# ATL 568     Insula 574+576+385   aIFG 377+379    pIFG 597
# AG 605+547 pMTG 604    SPS 584+587

# AG 547

cd /public/home/max/story2016fMRI/group/anat_ROIs

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
 
