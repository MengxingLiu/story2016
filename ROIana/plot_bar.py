#!/public/software/python/3.5.1/gnu/bin/python3.5
import sys
def plot_bar(m1,m2,m3,s1,s2,s3,task,ROI):
    import matplotlib.pyplot as plt
    import numpy as np
    mean = [m1, m2, m3]
    se = [s1, s2, s3]
    means = [float(x) for x in mean]
    ses = [float(x) for x in se]
    ind = np.arange(len(means))
    width = 0.36 
    plt.figure()
    plt.title(ROI)
    plt.bar(ind,means, width, linewidth = 1, color='white',edgecolor='black', align='center', yerr = ses, ecolor='k')
    plt.ylabel('Beta Value')
    plt.xticks(ind,('CS','US','SW'))
    if means[0] < 0:
        plt.axis(ymax=0)
    else:
        plt.axis(ymin=0)
    myfig = 'fig_'+ task + '_' + ROI + '.svg'
    plt.savefig(myfig)
    plt.close()
[m1,m2,m3,s1,s2,s3,task,ROI] = sys.argv[1:]

plot_bar(m1,m2,m3,s1,s2,s3,task,ROI)


