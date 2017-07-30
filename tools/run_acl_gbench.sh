#!/bin/bash
iters=$1
dir=$2
mkdir $2
CAFFE=build/tools/caffe
MODEL=models/bvlc_googlenet/deploy.prototxt
WEIGHTS=models/bvlc_googlenet/bvlc_googlenet.caffemodel
export BYPASSACL=0x0
$CAFFE test -model $MODEL -weights $WEIGHTS -iterations $iters -gpu all > $dir/gpu_out.txt
$CAFFE test -model $MODEL -weights $WEIGHTS -iterations $iters > $dir/cpu_out.txt
export BYPASSACL=0xffffffff
$CAFFE test -model $MODEL -weights $WEIGHTS -iterations $iters > $dir/cpu_normal_out.txt
