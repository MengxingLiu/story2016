#!/bin/csh
set spath = "/public/home/max/story2016fMRI/"
mkdir $spath/group/ISC/
foreach sub(sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 sub10 sub11 sub12 sub13 sub14 sub15 sub16 sub17 sub18 sub19 sub20 sub21 sub22 sub23 sub24 sub25 sub26 sub27 sub28 sub29 sub30 sub31 sub32 sub33)
	cd $spath/$sub/orig_files/
	foreach tp(NS CS US SW)
		rm ts_"$tp"_at.nii
		3dAFNItoNIFTI -prefix ts_"$tp"_"$sub".nii ts_"$tp"_at+tlrc.
		mv ts_"$tp"_"$sub".nii "$spath"/group/ISC/
		rm ts_"$tp"_at+tlrc.* ts_"$tp"+orig.*
	end
end

# move files to group level analysis
mkdir $spath/group/ISC/
foreach sub(sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 sub10 sub11 sub12 sub13 sub14 sub15 sub16 sub17 sub18 sub19 sub20 sub21 sub22 sub23 sub24 sub25 sub26 sub27 sub28 sub29 sub30 sub31 sub32 sub33)
	cd $spath/$sub/orig_files/
	foreach tp(NS CS US SW)
		rm ts_"$tp"_at.nii
		3dAFNItoNIFTI -prefix ts_"$tp"_"$sub".nii ts_"$tp"_at+tlrc.
		mv ts_"$tp"_"$sub".nii "$spath"/group/ISC/
		rm ts_"$tp"_at+tlrc.* ts_"$tp"+orig.*
	end
end

