#!/public/software/python/3.5.1/gnu/bin/python3.5

import numpy as np
import os
import matplotlib.pyplot as plt
def plot_curve( means, ses, ROI, task, block_index):
    plt.close()
    fig_size = plt.rcParams["figure.figsize"]
    fig_size[0] = 16
    fig_size[1] = 9
    csfont = {'fontname':'Ubuntu','fontsize':14}
    fig = plt.figure()
    ax = fig.add_subplot(111)
    plt.title(ROI+" in " +task, **csfont)
    plt.plot(np.arange(-10,-10+len(means[0][:])),means[0][:],
            color = '#45B39D', linewidth = 2,linestyle = '-',
            marker = 'o', markersize = 4, label = 'CS')
    plt.plot(np.arange(-10,-10+len(means[0][:]))[10:-12], means[0][10:-12],
            color = '#45B39D', linewidth= 3,linestyle = '-',
            marker = 'o', markersize = 4)
    plt.plot(np.arange(-10,-10+len(means[1][:])), means[1][:],
            color = '#CB4335', linewidth = 2,linestyle = '--',
            marker = 'D', markersize = 4,label = 'US')
    plt.plot(np.arange(-10,-10+len(means[1][:]))[10:-12], means[1][10:-12],
            color = '#CB4335', linewidth = 3,linestyle = '-',
            marker = 'D', markersize = 4)

    plt.plot(np.arange(-10,-10+len(means[2][:])), means[2][:],
            color = '#808B96', linewidth = 2, linestyle = ':',
            marker = 's', markersize = 4, label = 'SW')
    plt.plot(np.arange(-10,-10+len(means[2][:]))[10:-12], means[2][10:-12],
            color = '#808B96', linewidth = 3, linestyle = '-',
            marker = 's', markersize = 4)
    legend = plt.legend(loc=0,fancybox = True, edgecolor = '#ABB2B9',
                prop = {'family':'Ubuntu', 'size':14})
    legend.get_frame().set_linewidth(2)
    plt.ylabel('Changing percent', **csfont)
    'plt.xticks(index, (np.arange(-10,6)),**csfont)'
    
    plt.tick_params(axis = 'y', left = 'off',which='major',width=2,
                    color='#AEB6BF',direction='in')
    plt.tick_params(axis = 'x', bottom = 'off', width=2, direction='in',
                    color = '#AEB6BF')
    ax.set_xticks(np.arange(-10,22,2))
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    '''
    ax.spines['left'].set_linewidth(2)
    ax.spines['left'].set_color('#AEB6BF')
    ax.spines['bottom'].set_color('#AEB6BF')
    ax.spines['bottom'].set_linewidth(2)
    '''
    ax.spines['left'].set_visible(False)
    ax.spines['bottom'].set_visible(False)
    '''plt.axvspan(10, 16,facecolor='#CCD1D1')'''
    ' remove the last highlight column'
    'plt.axis(xmax = 16)'
    
    'set background color'
    ax.patch.set_facecolor('#E5E7E9')
    ax.grid(color='w', linewidth=2)
    ''' 
    plot with erro bar
    plt.errorbar(index, means[0,:],yerr = ses[0,:], 
                color = 'r',linewidth = 2,
                fmt = 'o',markersize = 4,capsize = 3,capthick = 2, 
                linestyle = '--', ecolor = 'y', label= 'CS')
    plt.errorbar(index, means[1,:],yerr = ses[1,:],
                color = 'g',linewidth = 2,
                fmt = 'o',markersize = 4,capsize = 3,capthick = 2,
                linestyle = ':', ecolor = 'r', label = 'US')
    plt.errorbar(index, means[2,:],yerr = ses[2,:],
                color = 'b', linewidth = 2,
                fmt = 'o',markersize = 4,capsize = 3,capthick = 2,
                linestyle = '-.', ecolor = 'g', label = 'SW')
    '''
    myfig = 'blockfig_'+ task + '_' + ROI + '_' + block_index + '.png'
    plt.savefig(myfig, dpi=300)



for i in range(10):
    for task in ('listen', 'read'):
        for ROI in ('aIFG', 'pIFG', 'FFG', 'Insula', 'SPS', 'ATL', 'mTC', 'AG'):
            means = np.empty(shape=[0,16])
            ses = np.empty(shape=[0,16])
            means = []
            ses = []
            block_index = '%02d' % (i+1)
            for condition in ('cs', 'us', 'sw'):
                a = 1
                X = []
                while a <= 33:
                    file_1D = '/public/home/max/story2016fMRI/group/ROI_ana/block_curve/%s_%s_%s_sub%02d_%s.1D' % (task, condition, ROI, a, block_index)
                    if os.path.exists(file_1D):
                        sub_curve = np.loadtxt(file_1D)
                        X.append(sub_curve.tolist())
                    a += 1
                X = np.array(X)
                'means = np.append(means, [np.mean(X,axis = 0)], axis = 0)'
                means.append(np.mean(X,axis = 0).tolist())

                std = np.std(X, axis = 0)
                'ses = np.append(ses, [np.divide(std, np.sqrt(len(X[:,0])))], axis = 0)'
                ses.append([np.divide(std,np.sqrt(len(X[:,0]))).tolist()])
            plot_curve(means, ses, ROI, task,block_index)
            print('the ' + block_index + ' for ' + task + ' of ' + ROI)




