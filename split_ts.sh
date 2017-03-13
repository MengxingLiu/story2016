#!/bin/csh

# this script split the whole time seires into 4 ts, each one contain only one condition


set spath = "/public/home/max/story2016fMRI"
set n = 2
while ( $n <= 33)
    
    set sub = (sub`count $n $n -digit 2`)
    echo "=============="$sub"========================"
    cd "$spath"/"$sub"/map2subAvg
    if (-e "ts.nii" ) then
        foreach type( CS US SW NS )
            3dTcat -prefix ts_"$type".nii.gz \
                ts.nii"[1dcat /public/home/max/scripts/story2016/index_$type.1D]"  
        end 
     endif
    @ n++
end


