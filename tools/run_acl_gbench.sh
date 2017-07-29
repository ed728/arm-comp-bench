#!/bin/bash
iters=$1
dir=$2
mkdir $2
alias caffe='/mnt/data/hikey/stuffs/ACL/caffeOnACL/build/tools/caffe'
CAFFE=build/tools/caffe
export BYPASSACL=0x0
$CAFFE test -model models/bvlc_googlenet/deploy.prototxt -weights models/bvlc_googlenet/bvlc_googlenet.caffemodel -iterations $iters -gpu all > $dir/gpu_out.txt
$CAFFE test -model models/bvlc_googlenet/deploy.prototxt -weights models/bvlc_googlenet/bvlc_googlenet.caffemodel -iterations $iters > $dir/cpu_out.txt
export BYPASSACL=0xffffffff
$CAFFE test -model models/bvlc_googlenet/deploy.prototxt -weights models/bvlc_googlenet/bvlc_googlenet.caffemodel -iterations $iters > $dir/cpu_normal_out.txt