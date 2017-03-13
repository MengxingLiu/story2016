#!/bin/csh

set spath = "/public/home/max/story2016fMRI/group/ISC"
# for each threshold, do conjunciton between conditions: CS US SW

3drefit -sublabel 0 listen_CS_p=.05 -sublabel 1 listen_CS_p=.01 -sublabel 2 listen_CS_p=.005 -sublabel 3 listen_CS_p=.001 -sublabel 4 listen_US_p=.05 -sublabel 5 listen_US_p=.01 -sublabel 6 listen_US_p=.005 -sublabel 7 listen_US_p=.001 -sublabel 8 listen_SW_p=.05 -sublabel 9 listen_SW_p=.01 -sublabel 10 listen_SW_p=.005 -sublabel 11 listen_SW_p=.001 -sublabel 12 listen_NS_p=.05 -sublabel 13 listen_NS_p=.01 -sublabel 14 listen_NS_p=.005 -sublabel 15 listen_NS_p=.001 -sublabel 16 read_CS_p=.05 -sublabel 17 read_CS_p=.01 -sublabel 18 read_CS_p=.005 -sublabel 19 read_CS_p=.001 -sublabel 20 read_US_p=.05 -sublabel 21 read_US_p=.01 -sublabel 22 read_US_p=.005 -sublabel 23 read_US_p=.001 -sublabel 24 read_SW_p=.05 -sublabel 25 read_SW_p=.01 -sublabel 26 read_SW_p=.005 -sublabel 27 read_SW_p=.001 -sublabel 28 read_NS_p=.05 -sublabel 29 read_NS_p=.01 -sublabel 30 read_NS_p=.005 -sublabel 31 read_NS_p=.001 isc_map.nii


foreach threshold(05 01 005 001)
    foreach modality(listen read)
        3dcalc -prefix isc_conjunction_"$modality"_"$threshold".nii.gz \
                -a isc_"$modality"_CS_"$threshold".nii \
                -b isc_"$modality"_US_"$threshold".nii \
                -c isc_"$modality"_SW_"$threshold".nii \
                -expr 'step(a) + 3* step(b) + 5* step(c)'
    end
end

3dbucket isc_conjunction_listen_05.nii.gz isc_conjunction_listen_01.nii.gz \
         isc_conjunction_listen_005.nii.gz isc_conjunction_listen_001.nii.gz \
        isc_conjunction_read_05.nii.gz isc_conjunction_read_01.nii.gz \
        isc_conjunction_read_005.nii.gz isc_conjunction_read_001.nii.gz \
        -prefix isc_conjunction_map.nii.gz

3drefit -sublabel 0 listen_05 -sublabel 1 listen_01 \
        -sublabel 2 listen_005 -sublabel 3 listen_001 \
        -sublabel 4 read_05 -sublabel 5 read_01 \
        -sublabel 6 read_005 -sublabel 7 read_001 \
        isc_conjunction_map.nii.gz

    
