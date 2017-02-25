import os, subprocess
from bs4 import BeautifulSoup
import re
import glob
"""
files = os.listdir()
runlist = []
for n in range(len(files)):
    f = open(files[n],"r")
    page = f.read()
    soup = BeautifulSoup(page, "html.parser")
    pattern = re.compile('Series: * | *sub*')
    "use findAll to get two tags"
    task = soup.findAll(['td','h3'],text = pattern)
    task = [n.text for n in task]
    print(task)
    runlist.append(task)

thefile = open('task.mx','w')
for item in runlist:
    thefile.write("%s\n" % item)
"""
with open('/media/max/Mengxing/story_rawdata2016/directory_contents/task.mx') as f:
    lines = f.read().splitlines()

task = [line[2:-2].split("', '") for line in lines]

task = [item for sublist in task for item in sublist ]

" get the index of sub info item "
b = []
for i, j in enumerate(task):
    if "sub" in j:
        b.append(i)
" seperate each sub"
task = [task[b[n]:b[n+1]] if n != 32 else task[b[n]:] for n in range(len(b))]

runlist = ["T1", "run01","run02", "run03", "run04", "run05"]

sublist = glob.glob("/media/max/Mengxing/story_rawdata2016/sub*")
sublist.sort()
"for n in range(len(sublist)):"
for n in range(len(sublist)):
    sub = ("sub%02d" % int(n + 1))
    print("#####################################################")
    print("starting with %s" % sub)
    print("#####################################################")
    
    "change dir to subject dir"
    os.chdir("/media/max/Mengxing/story_rawdata2016/%s/ST0" % sub)
    """os.mkdir("/media/max/Mengxing/story2016fMRI")
    os.mkdir("/media/max/Mengxing/story2016fMRI/%s/" % sub)"""
    "Recursive directory creation function. Like mkdir(), but makes all intermediate-level directories needed to contain the leaf directory."
    os.makedirs("/media/max/Mengxing/story2016fMRI/%s/orig_files/" % sub)
    SE = glob.glob("/media/max/Mengxing/story_rawdata2016/%s/ST0/*" % sub)
    SE.sort()
    datapath = ("/media/max/Mengxing/story2016fMRI/%s/orig_files/" % sub)
    for i,j in enumerate(task[n][1:]):
        "change dir to each task"
        
        os.chdir(SE[i])
        if "T1" in j:
            subprocess.call(["Dimon", "-GERT_Reco", "-infile_prefix", "IM", "-dicom_org",
						 "-quit", "-gert_nz", "176", "-gert_to3d_prefix", "Anatomical"])
            sh = glob.glob("GERT*")
            subprocess.call(["csh",sh[0]])
            "If you want to use call with the wildcard, you should pass the shell parameter as True. In this case, however, the command should be a string, not a list of arguments"
            subprocess.call("mv Ana* %s" % datapath, shell = True)
            subprocess.call("rm GERT* Ana*", shell = True)
        elif "Task 1" in j:
            subprocess.call(["Dimon", "-GERT_Reco", "-infile_prefix", "IM", "-dicom_org",
						 "-quit", "-gert_nz", "43", "-gert_to3d_prefix", "run01"])
            sh = glob.glob("GERT*")
            subprocess.call(["csh",sh[0]])
            subprocess.call("mv run* %s" % datapath, shell = True)
            subprocess.call("rm GERT* run*", shell = True)
        elif "Task 2" in j:
            subprocess.call(["Dimon", "-GERT_Reco", "-infile_prefix", "IM", "-dicom_org",
						 "-quit", "-gert_nz", "43", "-gert_to3d_prefix", "run02"])
            sh = glob.glob("GERT*")
            subprocess.call(["csh",sh[0]])
            subprocess.call("mv run* %s" % datapath, shell = True)
            subprocess.call("rm GERT* run*", shell = True)
        elif "Task 3" in j:
            subprocess.call(["Dimon", "-GERT_Reco", "-infile_prefix", "IM", "-dicom_org",
						 "-quit", "-gert_nz", "43", "-gert_to3d_prefix", "run03"])
            sh = glob.glob("GERT*")
            subprocess.call(["csh",sh[0]])
            subprocess.call("mv run* %s" % datapath, shell = True)
            subprocess.call("rm GERT* run*", shell = True)
        elif "Task 4" in j:
            subprocess.call(["Dimon", "-GERT_Reco", "-infile_prefix", "IM", "-dicom_org",
						 "-quit", "-gert_nz", "43", "-gert_to3d_prefix", "run04"])
            sh = glob.glob("GERT*")
            subprocess.call(["csh",sh[0]])
            subprocess.call("mv run* %s" % datapath, shell = True)
            subprocess.call("rm GERT* run*", shell = True)
        elif "Task 5" in j:
            subprocess.call(["Dimon", "-GERT_Reco", "-infile_prefix", "IM", "-dicom_org",
						 "-quit", "-gert_nz", "43", "-gert_to3d_prefix", "run05"])
            sh = glob.glob("GERT*")
            subprocess.call(["csh",sh[0]])
            subprocess.call("mv run* %s" % datapath, shell = True)
            subprocess.call("rm GERT* run*", shell = True)
    print("%s recon finished" % sub)


