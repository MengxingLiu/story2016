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

	3dMean -prefix mean_ts_listen_$tp.nii $listen
	3dMean -prefix mean_ts_read_$tp.nii $read
end
