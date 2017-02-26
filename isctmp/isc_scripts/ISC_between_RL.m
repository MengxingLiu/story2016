% this scripts avrage all null distribution generated in each sub and the group leve 
% null distribution are created, the values at 0.05 0.01 0.005 0.001 also are output
% Author: Max

% variable sub is defined in the command line before run this
spath = '/public/home/max/story2016fMRI/group/ISC/threshold/';
% load mask nii 
maskfile = '/public/home/max/story2016fMRI/group/mask_group.nii';
maskimg = load_nii(maskfile);
mask = single(maskimg.img);
[x,y,z,t] = size(mask);
distribution_img = zeros(x,y,z,1000);
threshold_img = zeros(x,y,z,6);
% load sum nii
		% list of subjects doing listening task
        sub4lis = {'sub02' 'sub03' 'sub04' 'sub05' 'sub06' 'sub07' 'sub08' 'sub09' ...
		'sub12' 'sub13' 'sub15' 'sub16' 'sub31' 'sub32'};
       % list of subjects doing reading task
        sub4read = {'sub10' 'sub11' 'sub14' 'sub17' 'sub19' 'sub20' 'sub21' 'sub22' ...
                    'sub23' 'sub24' 'sub25' 'sub26' 'sub27' 'sub28' 'sub29' 'sub33'};
for tp = {'CS' 'US' 'SW' 'NS'}
    tic;
	for sub = sub4lis
	   sub_image = load_nii([spath 'flipled2_' sub{1} '_' tp{1} '.nii' ]);
		sub_mat = single(sub_image.img);
	
	disp(['Working on ', tp{1}, ' of ' sub{1} ])
                    distribution_img = distribution_img + sub_mat;
       end
	distribution_img = distribution_img / length(sub4lis);          
	for vx = 1:x
		for vy = 1:y
			for vz = 1:z
				distribution_img(vx,vy,vz,:) = sort(distribution_img(vx,vy,vz,:));
				threshold_img(vx,vy,vz,:) = [distribution_img(vx,vy,vz,950) distribution_img(vx,vy,vz,990) ...
						distribution_img(vx,vy,vz,995) distribution_img(vx,vy,vz,999) ...
						 mean(distribution_img(vx,vy,vz,:)) std(distribution_img(vx,vy,vz,:))];
			end
		end
	end
    toc;
    save([spath 'mat_thrshd_lis_' tp{1} '.mat'],'threshold_img');
    save([spath 'mat_distri_lis_' tp{1} '.mat'],'distribution_img');
    nii_out = make_nii(threshold_img, [3 3 3]);
    save_nii(nii_out,[spath 'thrshd_lis' tp{1}, '.nii']);    

    nii_out = make_nii(distribution_img, [3 3 3]);
    save_nii(nii_out,[spath 'distr_lis' tp{1}, '.nii']);    
end

disp(['%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'])
disp(['%%%%%%%%%%%%%%%%%%% Finished!!!!%%%%%%%%%%%%%%%%%%%%%%%%'])
disp(['%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'])

