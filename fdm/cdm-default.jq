def read_job(name):
    .jobs[] | select(.jobname==name+"-RD") | { bw: (.read.bw / 1024 | floor), iops: (.read.iops | floor) };

def write_job(name):
    .jobs[] | select(.jobname==name+"-WR") | { bw: (.write.bw / 1024 | floor), iops: (.write.iops | floor) };

def mix_job(name): 
    .jobs[] | select(.jobname==name+"-MIX") | { bw: ([.read.bw, .write.bw] | add / 1024 | floor), iops: ([.read.iops, .write.iops] | add | floor) };

def summary(name):
    { job: name, read: read_job(name), write: write_job(name), mix: mix_job(name) };

[
    summary("SEQ1M-Q8T1"),
    summary("SEQ1M-Q1T1"),
    summary("RND4K-Q32T16"),
    summary("RND4K-Q1T1")
]
