#!/bin/bash

. /opt/intel/oneapi/setvars.sh intel64
. /vol0004/apps/oss/spack/share/spack/setup-env.sh

# spack find -l hdf5で一覧表示

#linux-rhel8-a64fx / fj@4.8.1
#spack load /jwsbmmp

#linux-rhel8-a64fx / fj@4.10.0
#spack load /zpd2xho
#spack load /f2rs4lm
#spack load /sr23pzm
#spack load /kybzesz
#spack load /ewlqc4w
#spack load /yhazdvl

#linux-rhel8-a64fx / gcc@8.5.0
#spack load /a4zpxqt

#linux-rhel8-cascadelake / gcc@13.2.0
#spack load /xddqngh
#spack load /3mmqri6

#linux-rhel8-skylake_avx512 / gcc@8.5.0
#spack load /zpysinb
#spack load /lwcglyr
spack load /zzyvoyb

LDFLAGS=-lhdf5

icpx $LDFLAGS hdfsample.c -o hdf-c-intel.elf

# コンパイルの成功を確認
if [ $? -eq 0 ]; then
    echo "コンパイル成功！"
    ./hdf-c-intel.elf
else
    echo "ERROR コンパイル失敗。"
fi

echo "library path="

#すべての互換性のあるhdf5インクルードパスにはmodファイルがないためコンパイルできない
LDFLAGS="-lhdf5_fortran -lhdf5"

ifx $LDFLAGS hdfsample.f90

# コンパイルの成功を確認
if [ $? -eq 0 ]; then
    echo "コンパイル成功！"
    ./hdf-c-intel.elf
else
    echo "ERROR コンパイル失敗。"
fi
