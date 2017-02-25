
% load mask nii 

% variable sub is defined in the command line before run this
rpath = '/public/home/max/story2016fMRI/group/ISC/threshold/';
spath = '/public/home/max/story2016fMRI/group/ISC/orig_files/';
maskfile = '/public/home/max/story2016fMRI/group/mask_group.nii';
maskimg = load_nii(maskfile);
mask = single(maskimg.img);

for tp =  {'NS' 'CS' 'US' 'SW'}
       % list of subjects doing listening task
        sub4lis = {'sub02' 'sub03' 'sub04' 'sub05' 'sub06' 'sub07' 'sub08' 'sub09' ...
		'sub12' 'sub13' 'sub15' 'sub16' 'sub31' 'sub32'};
       % list of subjects doing reading task
        sub4read = {'sub10' 'sub11' 'sub14' 'sub17' 'sub19' 'sub20' 'sub21' 'sub22' ...
                    'sub23' 'sub24' 'sub25' 'sub26' 'sub27' 'sub28' 'sub29' 'sub33'};
% load sum image

	sum_image = load_nii([spath 'listen_sum_' tp{1} '.nii']);
	sum_mat = sum_image.img;
	[x,y,z,t] = size(sum_mat);
	iteration = 1000;
	nulldistribution = zeros(x,y,z,iteration);
	%load specific subject timeseires
	for sub = sub4lis
		tic;
		sub_image = load_nii([spath 'ts_' tp{1} '_' sub{1} '.nii' ]);
		sub_mat = sub_image.img;

	% average_without specific subject
		average_ts = sum_mat - sub_mat;

		for vx = 1:x 
			for vy = 1:y
				for vz = 1:z
			
					sum_ts = squeeze(sum_mat(vx,vy,vz,:));
					sub_ts = squeeze(sub_mat(vx,vy,vz,:));
					for n = 1:iteration
						[sum_ts_rand,x_amp,sym_phase] = phase_rand_corr_mat_new(sum_ts,1);
						r = corr(sub_ts, sum_ts_rand);
						nulldistribution(vx,vy,vz,n) = nulldistribution(vx,vy,vz,n) + r;

					end
				end
			end
		end
		toc;
	end
	avg_nulldistribution = nulldistribution / length(sub4lis);
	sorted_avg_nulldistribution = sort(avg_nulldistribution,4);
	nii_out = make_nii(sorted_avg_nulldistribution, [3 3 3]);
    	save_nii(nii_out,[rpath 'distr_', tp{1}, '.nii'])    
end

