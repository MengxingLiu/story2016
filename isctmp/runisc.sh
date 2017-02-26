#!/bin/sh
nohup matlab -nosplash -nodisplay -nojvm -nodesktop -logfile isc_log_sub03.log -r "sub = 'sub03'; cd /public/home/max/scripts/story2016/isctmp/isc_scripts; s10_bootstrap; exit"  

# after run the command, ctrl+z to suspend the progress and bg to move it background
