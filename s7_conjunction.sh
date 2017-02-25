#!/bin/csh

set dpath = "/public/home/max/story2016fMRI/group/MVM"
cd $dpath
# conjunction of CS R&L
	3dcalc -a Clustermask.nii.gz'[4]' -b Clustermask.nii.gz'[7]' \
		-expr 'step(a)+2*step(b)' -prefix conj_CS.nii.gz
# conjunction of US R&L
	3dcalc -a Clustermask.nii.gz'[5]' -b Clustermask.nii.gz'[8]' \
		-expr 'step(a) + 2* step(b)' -prefix conj_US.nii.gz
# conjunction of SW R&L
	3dcalc -a Clustermask.nii.gz'[6]' -b Clustermask.nii.gz'[9]' \
		-expr 'step(a) + 2* step(b)' -prefix conj_SW.nii.gz
# conjunction of R&L
	3dcalc -a Clustermask.nii.gz'[10]' -b Clustermask.nii.gz'[11]' \
		-expr 'step(a) + 2* step(b)' -prefix conj_RL.nii.gz
# conjunction of CS&US&SW for L
 	3dcalc -a Clustermask.nii.gz'[4]' -b Clustermask.nii.gz'[5]' \
		-c Clustermask.nii.gz'[6]' \
		-expr 'step(a) + 3* step(b) + 5* step(c)' \
		-prefix conj_scale_L.nii.gz
# conjunction of CS&US&SW for R 	
	3dcalc -a Clustermask.nii.gz'[7]' -b Clustermask.nii.gz'[8]' \
		-c Clustermask.nii.gz'[9]' \
		-expr 'step(a) + 3* step(b) + 5* step(c)' \
		-prefix conj_scale_R.nii.gz
	
	
	3dbucket conj_CS.nii.gz conj_US.nii.gz conj_SW.nii.gz conj_RL.nii.gz \
		conj_scale_L.nii.gz conj_scale_R.nii.gz \
		-prefix conj_R_L.nii.gz
