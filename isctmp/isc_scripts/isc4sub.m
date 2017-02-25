% load mask nii 

% variable sub is defined in the command line before run this
rpath = '/public/home/max/story2016fMRI/group/ISC/threshold/';
spath = '/public/home/max/story2016fMRI/group/ISC/orig_files/';
maskfile = '/public/home/max/story2016fMRI/group/mask_group.nii';
maskimg = load_nii(maskfile);
mask = single(maskimg.img);
[x,y,z,t] = size(mask);
thresholdimg = zeros(x,y,z,5);
distribution_img = zeros(x,y,z,1000);
iteration = 1000;
for condition = {'CS' 'US' 'SW' 'NS'}
    tic;
    filename = [spath 'ts_' condition{1} '_' sub '.nii'];
    f = load_nii(filename);
    f = single(f.img);
    for vx = 1:x 
	disp(['Working on ', condition{1}, ' of ' sub ', slice x = ', num2str(vx)])
        for vy = 1:y 
            %vy
            for vz = 1:z 
                if mask(vx,vy,vz) ~= 0
                    timeseries = squeeze(f(vx,vy,vz,:));
                    nulldistribution = bootstraptest(timeseries,iteration);
                    distribution_img(vx,vy,vz,:) = nulldistribution(:);
		    thresholdimg(vx,vy,vz,:) = [nulldistribution(950),nulldistribution(990),nulldistribution(995),mean(nulldistribution),std(nulldistribution)];
                end
                
            end
            %toc;
        end
    end
    toc;
    nii_out = make_nii(distribution_img, [3 3 3]);
    save_nii(nii_out,[rpath 'distr_', sub, '_', condition{1}, '.nii'])    
end

disp(['%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'])
disp(['%%%%%%%%%%%%%%%' sub ' Finished!!!!%%%%%%%%%%%%%%%%%%%%%'])
disp(['%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'])

