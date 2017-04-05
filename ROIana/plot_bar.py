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
    plt.rc('lines', linewidth=5, color='r') 
    csfont = {'fontname':'Arial','fontsize':18}
    fig=plt.figure()
    ax = fig.add_subplot(111)
    plt.title(ROI,**csfont)
    for axis in ['top','bottom','left','right']:
        ax.spines[axis].set_linewidth(2)
    ax.spines['bottom'].set_color('none')
    ax.spines['right'].set_color('none')
    bars = plt.bar(ind,means, width, linewidth = 2, color='white',edgecolor='black', align='center', ecolor='k', fill= 'True')
    patterns = ('','///','...')
    for bar , pattern in zip(bars, patterns):
        bar.set_hatch(pattern)
    plt.errorbar(ind,means,yerr = ses,elinewidth=2, capsize=5,capthick=3, color = 'black',fmt='o', markersize=8, markerfacecolor='yellow')
    plt.ylabel('Beta Value',**csfont)
    plt.xticks(ind,('CS','US','SW'),**csfont)
    plt.yticks(**csfont)
    
    plt.tick_params(which='major',width=2,direction='in')
    if means[0] < 0:
        plt.axis(ymax=0)
    else:
        plt.axis(ymin=0)
    myfig = 'fig_'+ task + '_' + ROI + '.svg'
    plt.savefig(myfig)
    plt.show()
"[m1,m2,m3,s1,s2,s3,task,ROI] = sys.argv[1:]"
m1 = -0.01135
m2 = -0.01100
m3 = -0.01073
s1 = 0.00187
s2 = 0.00195
s3 = 0.00205
task = "listen"
ROI = "aIFG"

plot_bar(m1,m2,m3,s1,s2,s3,task,ROI)


