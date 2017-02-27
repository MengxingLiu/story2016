#!/bin/csh
# matlab -nodesktop -logfile boot_sub03.log -nosplash -nojvm -r "cd ~/isctmp; sub = 'sub03'; isc4sub; quit" 
# 3drefit -duporigin mask_group.nii -orient RAI test.nii
# 3dLRflip -prefix a.nii -AP test.nii
# 3dLRflip -prefix b.nii -LR a.nii

foreach tp(CS US SW NS)
foreach sub(sub02 sub03 sub04 sub05 sub06 sub07 sub08 sub09 \
                        sub12 sub13 sub15 sub16 sub31 sub32 \
            sub10 sub11 sub14 sub17 sub19 sub20 sub21 sub22 \
            sub23 sub24 sub25 sub26 sub27 sub28 sub29 sub33)
       
	3drefit -duporigin mask_group.nii -orient RAI *"$sub"_"$tp".nii
	3dLRflip -prefix flipled_"$sub"_"$tp".nii -AP *"$sub"_"$tp".nii
	3dLRflip -prefix flipled2_"$sub"_"$tp".nii -AP flipled_"$sub"_"$tp".nii 

end
end

foreach tp(CS US SW NS)
    3drefit -duporigin mask_group.nii -orient RAI thrshd_intergroup_"$tp".nii
    3dLRflip -prefix flipled_"$tp".nii -AP thrshd_intergroup_"$tp".nii
    3dLRflip -prefix thrshd_intergroup_"$tp"_flipled.nii -AP flipled_"$tp".nii
    rm flipled_"$tp".nii
end

