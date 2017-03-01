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
