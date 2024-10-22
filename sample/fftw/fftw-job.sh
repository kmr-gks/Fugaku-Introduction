#!/bin/sh -x
#PJM -L  "node=4"            # 割当ノード 4ノード （1次元形状）
#PJM -L  "rscgrp=small"      # リソースグループの指定
#PJM -L  "elapse=10:00"   # 経過時間制限 10min
#PJM --mpi "shape=4"         # 静的プロセス形状
#PJM --mpi "proc=4"          # 静的プロセスの最大数4
#PJM -x PJM_LLIO_GFSCACHE=/vol0004 #spackを使うとき指定
#

echo module loading...
#モジュールロードがいるかも
. /vol0004/apps/oss/spack/share/spack/setup-env.sh
spack load /upvlzyl
spack load /jsp5keo

echo "run directly"

echo "fftw-fcc.elf"
./fftw-fcc.elf
echo "fftw-gcc.elf"
./fftw-gcc.elf
echo "fftw-gfort.elf"
./fftw-gfort.elf

echo "done"
