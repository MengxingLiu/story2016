#!/bin/csh

##  this script do ISC analysis for each level in each factor
##  every subj 
set spath = '/media/max/Mengxing/story2016fMRI/group/ISC/orig_files'
cd $spath
rm r_* z_*
## tp as each level in Factor:Scale
foreach tp(NS CS US SW)
	set listen = (ts_"$tp"_sub02.nii ts_"$tp"_sub03.nii ts_"$tp"_sub04.nii \
			ts_"$tp"_sub05.nii ts_"$tp"_sub06.nii ts_"$tp"_sub07.nii \
			ts_"$tp"_sub08.nii ts_"$tp"_sub09.nii ts_"$tp"_sub12.nii \
			ts_"$tp"_sub13.nii ts_"$tp"_sub15.nii ts_"$tp"_sub16.nii \
			ts_"$tp"_sub31.nii ts_"$tp"_sub32.nii)
	set read = (ts_"$tp"_sub10.nii ts_"$tp"_sub11.nii ts_"$tp"_sub14.nii \
			ts_"$tp"_sub17.nii ts_"$tp"_sub19.nii ts_"$tp"_sub20.nii \
			ts_"$tp"_sub21.nii ts_"$tp"_sub22.nii ts_"$tp"_sub23.nii \
			ts_"$tp"_sub24.nii ts_"$tp"_sub25.nii ts_"$tp"_sub26.nii \
			ts_"$tp"_sub27.nii ts_"$tp"_sub28.nii ts_"$tp"_sub29.nii \
			ts_"$tp"_sub33.nii)
	# list of subjects doing listening task
	set sub4lis = (sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 \
			sub12 sub13 sub15 sub16 sub31 sub32)
	# list of subjects doing reading task
	set sub4read = (sub10 sub11 sub14 sub17 sub19 sub20 sub21 sub22 \
			sub23 sub24 sub25 sub26 sub27 sub28 sub29 sub33)

# there are 14 subs in listen task and 16 subs in read task
	set i = 1
		while ($i <= 14 )
			set sub=(`echo ${sub4lis} | awk '{print $'$i'}'`)
			# get the datasets list of rest in the group except $sub
			set rest_group=(`echo $listen | awk '{$'$i'="";print}'`)
			3dMean -prefix mean_group.nii $rest_group
			3dTcorrelate -pearson -polort -1 \
				-prefix r_"$tp"_"$sub".nii \
				ts_"$tp"_$sub.nii mean_group.nii
			3dcalc -a r_"$tp"_"$sub".nii \
				-expr '0.5*(log((1+a)/(1-a)))' \
				-prefix z_lis_"$tp"_"$sub".nii
			rm mean_group.nii
			@ i ++
		end
	set i = 1
		while ($i <= 16 )
			set sub=(`echo ${sub4read} | awk '{print $'$i'}'`)
			# get the datasets list of rest in the group except $sub
			set rest_group=(`echo $read | awk '{$'$i'="";print}'`)
			3dMean -prefix mean_group.nii $rest_group
			3dTcorrelate -pearson -polort -1 \
				-prefix r_"$tp"_"$sub".nii \
				ts_"$tp"_$sub.nii mean_group.nii
			3dcalc -a r_"$tp"_"$sub".nii \
				-expr '0.5*(log((1+a)/(1-a)))' \
				-prefix z_read_"$tp"_"$sub".nii
			rm mean_group.nii
			@ i ++
		end

end
	foreach tp(CS US SW)
		3dttest++ -setA z_lis_"$tp"_*.nii -setB z_lis_NS_*.nii \
			-paired -prefix isc_lis_"$tp".nii
		3dttest++ -setA z_read_"$tp"_*.nii -setB z_read_NS_*.nii \
			-paired -prefix isc_read_"$tp".nii
	end
	

