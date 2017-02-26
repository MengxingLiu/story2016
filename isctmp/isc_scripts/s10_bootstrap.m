
% A distribution of 1000 bootstrapped average ...
% correlations was calculated for each voxel
% in the same manner as the EMPIRICAL correlation maps described.

% Author: Max 
% Date: Nov 2016




% load mask nii 
% variable sub is defined in the command line before run this
rpath = '/public/home/max/story2016fMRI/group/ISC/threshold/';
spath = '/public/home/max/story2016fMRI/group/ISC/orig_files/';
maskfile = '/public/home/max/story2016fMRI/group/mask_group.nii';
maskimg = load_nii(maskfile);
mask = single(maskimg.img);

for tp =  {'NS' 'CS' 'US' 'SW'}
%       list of subjects doing listening task
    sub4lis = {'sub02' 'sub03' 'sub04' 'sub05' ...
        	'sub06' 'sub07' 'sub08' 'sub09' ...
		'sub12' 'sub13' 'sub15' 'sub16' ...
		'sub31' 'sub32'};
%       list of subjects doing reading task
    sub4read = {'sub10' 'sub11' 'sub14' 'sub17' ...
		'sub19' 'sub20' 'sub21' 'sub22' ...
                'sub23' 'sub24' 'sub25' 'sub26' ...
        	'sub27' 'sub28' 'sub29' 'sub33'};

% load average time seires of Reading group

    avg_image = load_nii([spath 'avg_r_read_' tp{1} '.nii']);
    avg_mat = avg_image.img;
    [x,y,z,t] = size(avg_mat);
    iteration = 1000;
    nulldistribution = zeros(x,y,z,iteration);
% load specific subject timeseires
    tic;
    sub_image = load_nii([spath 'ts_' tp{1} '_' sub '.nii' ]);
    sub_mat = sub_image.img;

    for vx = 1:x 
        disp([ 'Working on ' num2str(vx) '/' num2str(x) ' of ' sub]);
    for vy = 1:y
    for vz = 1:z
        if mask(vx,vy,vz) ~= 0
	    avg_ts = squeeze(avg_mat(vx,vy,vz,:));
	    sub_ts = squeeze(avg_mat(vx,vy,vz,:));
	    for n = 1:iteration
	        [avg_ts_rand,x_amp,sym_phase] = phase_rand_corr_mat_new(avg_ts,1);
	        r = corr(sub_ts, avg_ts_rand);
	        nulldistribution(vx,vy,vz,n) = r;
	    end
	end
    end
    end
    end
    toc;
% save r nulldistribution as a mat file
    save([rpath 'r_distribution_' tp{1} '_' sub '.mat' ], 'nulldistribution');
end

