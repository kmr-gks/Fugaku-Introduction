#!/bin/bash

. /vol0004/apps/oss/gcc-arm-11.2.1/setup-env.sh
. /vol0004/apps/oss/spack/share/spack/setup-env.sh

# spack find -l fftw で一覧表示

#linux-rhel8-a64fx / fj@4.10.0
#spack load /tvu5j7p
#spack load /nu4pin4

#linux-rhel8-a64fx / fj@4.11.1
spack load /upvlzyl

#linux-rhel8-a64fx / gcc@8.5.0
#spack load /zs6ha4o

#linux-rhel8-a64fx / gcc@12.2.0
#spack load /fqi6yr7

#linux-rhel8-cascadelake / gcc@13.2.0
#spack load /3e5et5m

#linux-rhel8-skylake_avx512 / gcc@8.5.0
#spack load /jsp5keo

LDFLAGS=-lfftw3

echo "計算ノード向け(C)"

gcc -c fftwsample.c -o fftw-gcc.o && mpifccpx fftw-gcc.o $LDFLAGS -o fftw-gcc.elf

# コンパイルの成功を確認
if [ $? -eq 0 ]; then
    echo "コンパイル成功！"
else
    echo "ERROR コンパイル失敗。"
fi

echo "計算ノード向け(Fortran)"

gfortran -c fftwsample.c -o fftw-gfort.o && mpifccpx fftw-gfort.o $LDFLAGS -o fftw-gfort.elf

# コンパイルの成功を確認
if [ $? -eq 0 ]; then
    echo "コンパイル成功！"
else
    echo "ERROR コンパイル失敗。"
fi
