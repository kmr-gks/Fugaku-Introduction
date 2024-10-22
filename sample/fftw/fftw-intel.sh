#!/bin/bash

. /opt/intel/oneapi/setvars.sh intel64
. /vol0004/apps/oss/spack/share/spack/setup-env.sh

# spack find -l fftw で一覧表示

#linux-rhel8-a64fx / fj@4.10.0
#spack load /tvu5j7p
#spack load /nu4pin4

#linux-rhel8-a64fx / fj@4.11.1
#spack load /upvlzyl

#linux-rhel8-a64fx / gcc@8.5.0
#spack load /zs6ha4o

#linux-rhel8-a64fx / gcc@12.2.0
#spack load /fqi6yr7

#linux-rhel8-cascadelake / gcc@13.2.0
#spack load /3e5et5m

#linux-rhel8-skylake_avx512 / gcc@8.5.0
spack load /jsp5keo

LDFLAGS=-lfftw3

icpx $LDFLAGS fftwsample.c -o fftw-c-intel.elf

# コンパイルの成功を確認
if [ $? -eq 0 ]; then
    echo "コンパイル成功！"
    ./fftw-c-intel.elf
else
    echo "ERROR コンパイル失敗。"
fi

LDFLAGS="-lfftw3 -I /vol0004/apps/oss/spack-v0.21/opt/spack/linux-rhel8-skylake_avx512/gcc-8.5.0/fftw-3.3.10-jsp5keotxixr2m3iclsxy4z3r4qqs6hf/include"

ifx $LDFLAGS fftwsample.f90 -o fftw-f-intel.elf

# コンパイルの成功を確認
if [ $? -eq 0 ]; then
    echo "コンパイル成功！"
    ./fftw-f-intel.elf
else
    echo "ERROR コンパイル失敗。"
fi
