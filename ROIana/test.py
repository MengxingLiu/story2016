import numpy as np
import os 
import matplotlib.pyplot as plt


def plot_curve(index, means, ses, ROI, task):
    csfont = {'fontname':'Arial','fontsize':18}
    plt.title(ROI+" in " +task, **csfont)
    plt.errorbar(index, means[0,:],yerr = ses[0,:], 
                color = 'r',linestyle = '--', ecolor = 'y', label= 'CS')
    plt.errorbar(index, means[1,:],yerr = ses[1,:],
                color = 'g', linestyle = ':', ecolor = 'r', label = 'US')
    plt.errorbar(index, means[2,:],yerr = ses[2,:],
                color = 'b', linestyle = '-.', ecolor = 'g', label = 'SW')
    plt.legend(loc=0)
    plt.ylabel('Changing percent', **csfont)
    plt.xticks(index, (np.arange(-10,6)),**csfont)
    plt.show()




task = 'listen'
ROI = 'aIFG'
means = np.empty(shape=[0,16])
ses = np.empty(shape=[0,16])
for condition in ('cs', 'us', 'sw'):
    a = 1
    X = np.empty(shape=[0,16])
    while a <= 33:
        file_1D = '/public/home/max/story2016fMRI/group/ROI_ana/block_curve/%s_%s_%s_sub%02d.1D' % (task, condition, ROI, a)
        if os.path.exists(file_1D):
            sub_curve = np.loadtxt(file_1D)
            X = np.append(X, [sub_curve], axis = 0)
        a += 1

    means = np.append(means, [np.mean(X,axis = 0)], axis = 0)
    std = np.std(X, axis = 0)
    ses = np.append(ses, [np.divide(std, np.sqrt(len(X[:,0])))], axis = 0)
    index = np.arange(0,len(means[0,:]))

print(means)
print(ses)
plot_curve(index, means, ses, ROI, task)


