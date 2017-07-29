import sys
import csv

d = sys.argv[1] + "/"
gpu_file = d + "gpu_out.txt"
cpu_file = d + "cpu_out.txt"
cpu_normal_file = d + "cpu_normal_out.txt"

gpu_raw = list(csv.reader(open(gpu_file, "rb"), delimiter='\t'))
cpu_raw = list(csv.reader(open(cpu_file, "rb"), delimiter='\t'))
cpu_normal_raw = list(csv.reader(open(cpu_normal_file, "rb"), delimiter='\t'))[2:]

def remove_empty(raw):
    res = []
    for r in raw:
        res.append([x for x in r if x])
    return res

def remove_white(white):
    res = []
    for w in white:
        name = w[0][0:-1].strip()
        val = float(w[1].strip())
        res.append((name, val))
    return res

def accum(vals):
    acc = {}
    for v in vals:
        if v[0] in acc:
            acc[v[0]].append(v[1])
        else:
            acc[v[0]] = []
    return acc
def str_totals(vals):
    res = ""
    for k, val in vals.iteritems():
        res += "{0}: {1}\t".format(k, sum(val)/len(val))
    return res
        
def process(data):
    return accum(remove_white(remove_empty(data))) 
gpu = process(gpu_raw)
print("GPU:")
print(str_totals(gpu))

cpu = process(cpu_raw)
print("CPU:")
print(str_totals(cpu))

cpu_normal = process(cpu_normal_raw)
print("CPU NORMAL:")
print(str_totals(cpu_normal))

