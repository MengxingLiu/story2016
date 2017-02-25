#!/bin/csh
      \rm -f qq*.out

      find . -type f \
        | xargs dicom_hinfo -tag 0008,0031 0028,0010 0028,0011 0018,1030 \
        | awk '$3 == $4' >> qqa.out

      uniq -f 1 -c qqa.out | awk '$1 > 50' > qqb.out

      foreach ddd ( ep2d_pace_REST NAMING_1 NAMING_2 \
			JUDGING_1 JUDGING_2 JUDGING_3 t1_mprage)
        echo "Organizing files with time stamp $ddd"
        grep $ddd qqa.out | awk '{print $1}' > qqc_${ddd}.out
        Dimon -infile_list qqc_${ddd}.out -dicom_org -GERT_Reco \
              -gert_create_dataset -gert_to3d_prefix ACQT_${ddd} -quit
      end

#DTI file label = 'ep2d_diff_MDDW_20_p2'
#Rest file label = 'ep2d_pace_REST'
#Naming_1 label = 'NAMING_1'
#Naming_2 label = 'NAMING_2'
#JUDGING_1 label = 'JUDGING_1'
#JUDGING_2 label = 'JUDGING_2'
#JUDGING_3 label = 'JUDGING_3'
#T1 file label = 't1_mprage'
