with open('clustersize.mx','r') as f:

    a = f.readlines()
n = [1,2,3,49,50,51,52,53,54,55,56,57]
n = [m-1 for m in n]
"repeat below command for (subbirck times)"
i = 1
while ( i < 8 ): 
    n = n + [m + 87 for m in n[-12:]]
    i += 1

with open('disclustsim.mx','w') as f:
    for i in n:
        f.write(a[i])

 
