#!/bin/csh
# Author:Max


# get the emprical average r of listen vs read group
#
set spath = "/public/home/max/story2016fMRI/group/ISC/orig_files"
set rpath = "/public/home/max/story2016fMRI/group/ISC/threshold"
cd $rpath
foreach tp(NS CS US SW)
    foreach sub(sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 \
                sub12 sub13 sub15 sub16 sub31 sub32)
        3dTcorrelate -pearson -polort -1 \
            -prefix r_intergroup_"$tp"_"$sub".nii \
            "$spath"/ts_"$tp"_"$sub".nii "$spath"/mean_ts_read_$tp.nii
    end
    3dMean -prefix mean_r_intergroup_"$tp".nii r_intergroup_"$tp"_sub*.nii


end

# combine the empirical r and the bootstrapping test threshold

foreach tp(NS CS US SW)
    3dcalc -prefix "$tp"_thresholed_05.nii \
            -a mean_r_intergroup_"$tp".nii \
            -b thrshd_intergroup_"$tp"_flipled.nii\[0] \
            -expr 'a*step(a-b)'
    3dcalc -prefix "$tp"_thresholed_01.nii \
           -a mean_r_intergroup_"$tp".nii \
           -b thrshd_intergroup_"$tp"_flipled.nii\[1] \
           -expr 'a*step(a-b)'
    3dcalc -prefix "$tp"_thresholed_005.nii \
           -a mean_r_intergroup_"$tp".nii \
           -b thrshd_intergroup_"$tp"_flipled.nii\[2] \
           -expr 'a*step(a-b)'
    3dcalc -prefix "$tp"_thresholed_001.nii \
           -a mean_r_intergroup_"$tp".nii \
           -b thrshd_intergroup_"$tp"_flipled.nii\[3] \
           -expr 'a*step(a-b)'
end       

foreach tp(NS CS US SW)
    3dbucket -prefix "$tp"_intergroup_map.nii \
        "$tp"_thresholed_05.nii \
        "$tp"_thresholed_01.nii \
        "$tp"_thresholed_005.nii \
        "$tp"_thresholed_001.nii

end


    3dbucket -prefix ISC_intergroup_map.nii \
        CS_intergroup_map.nii US_intergroup_map.nii \
        SW_intergroup_map.nii NS_intergroup_map.nii

    3drefit -sublabel 0 CS_05 \
            -sublabel 1 CS_01 \
            -sublabel 2 CS_005 \
            -sublabel 3 CS_001 \
            -sublabel 4 US_05 \
            -sublabel 5 US_01 \
            -sublabel 6 US_005 \
            -sublabel 7 US_001 \
            -sublabel 8 SW_05 \
            -sublabel 9 SW_01 \
            -sublabel 10 SW_005 \
            -sublabel 11 SW_001 \
            -sublabel 12 NS_05 \
            -sublabel 13 NS_01 \
            -sublabel 14 NS_005 \
            -sublabel 15 NS_001 \
            ISC_intergroup_map.nii
            

