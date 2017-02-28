#!/bin/csh

foreach tp(NS CS US SW)
        set listen = (r_"$tp"_sub02.nii r_"$tp"_sub03.nii r_"$tp"_sub04.nii \
                        r_"$tp"_sub05.nii r_"$tp"_sub06.nii r_"$tp"_sub07.nii \
                        r_"$tp"_sub08.nii r_"$tp"_sub09.nii r_"$tp"_sub12.nii \
                        r_"$tp"_sub13.nii r_"$tp"_sub15.nii r_"$tp"_sub16.nii \
                        r_"$tp"_sub31.nii r_"$tp"_sub32.nii)
        set read = (r_"$tp"_sub10.nii r_"$tp"_sub11.nii r_"$tp"_sub14.nii \
                        r_"$tp"_sub17.nii r_"$tp"_sub19.nii r_"$tp"_sub20.nii \
                        r_"$tp"_sub21.nii r_"$tp"_sub22.nii r_"$tp"_sub23.nii \
                        r_"$tp"_sub24.nii r_"$tp"_sub25.nii r_"$tp"_sub26.nii \
                        r_"$tp"_sub27.nii r_"$tp"_sub28.nii r_"$tp"_sub29.nii \
                        r_"$tp"_sub33.nii)
	3dMean -prefix avg_r_listen_"$tp".nii $listen
	3dMean -prefix avg_r_read_"$tp".nii $read
end

