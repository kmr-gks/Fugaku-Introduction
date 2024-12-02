# Fugaku-Introduction

### スーパーコンピュータ「富岳」の使い方

### 目次

-[目次](#目次)

-[接続前の設定](#接続前の設定)

-[ストレージについて](#ストレージについて)

-[モジュールについて](#モジュールについて)

-[サンプルコード](#サンプルコード)

-[ジョブの投入と確認](#ジョブの投入と確認)

### 接続前の設定

まず、理研から届くメールに添付されている証明書をインストールする

公式ページ([https://www.fugaku.r-ccs.riken.jp/](https://www.fugaku.r-ccs.riken.jp/))に接続できるか確認する。富岳に関する情報はここにまとまっている。

[ユーザーポータル](https://www.fugaku.r-ccs.riken.jp/user_portal/#/publickey_registration)から公開鍵を登録する。

SSHの設定をする

```
Host fugaku
	HostName login.fugaku.r-ccs.riken.jp
	User (user name)
	IdentityFile ~/.ssh/id_rsa_cs
```

### ストレージについて

富岳には

* ホームディレクトリ
* データディレクトリ
* シェアディレクトリ
* tmpfsディレクトリ
* 2ndfsディレクトリ

の5つのファイルシステムがある。

ホームディレクトリ(~)には20GBの容量制限があるため注意する。

使用量は[ここ](https://ondemand.fugaku.r-ccs.riken.jp/pun/sys/Disk_Info)で確認できる。

2ndfsの使用可能容量が多いこと、ログインノードを計算ノード双方からアクセスできることから私はホームディレクトリに2ndfsディレクトリへのシンボリックリンクを作成して運用しています。

```
ln -s /2ndfs/(group name)/(your dir name) ~/(link name)
```

`(group name)`はアカウント登録時に割り当てられたグループ名(例: hp999999)。

### モジュールについて

moduleコマンドを使う場合と、spackを使う場合がある。
spackを使用するときは

`. /vol0004/apps/oss/spack/share/spack/setup-env.sh`

を実行する。
[公式ページ](https://www.fugaku.r-ccs.riken.jp/doc_root/ja/user_guides/FugakuSpackGuide/intro.html#setup)によると、ファイルシステムにトラブルがある場合ログインできなくなる恐れがあるため、`.bashrc`に追加することは非推奨とのこと。

モジュールの一覧は`spack find`や`module avail`で確認できる。
モジュールの名前のハッシュ値は`spack find -l`で確認できる。

### サンプルコード

富岳公式のサンプルコードは `/home/system/sample`にある。

### ジョブファイルの作成
以下は月面EMSES用exp_surface_with_pe条件のジョブスクリプトである。このスクリプトの意味を説明する。
```bash
#!/bin/bash
#PJM -L  "node=4"            # volume of node (4 nodes to use more memory)
#PJM --mpi proc=128          # MPI process number
#PJM -L  "rscgrp=small"      # resource group
#PJM -L  "elapse=10:00:00"   # time limit
#PJM -x PJM_LLIO_GFSCACHE=/vol0004 # specify when using spack
#PJM -g hp240400

#loading modules
. /vol0004/apps/oss/spack/share/spack/setup-env.sh
spack load /yhazdvl
spack load /upvlzyl

#https://www.fugaku.r-ccs.riken.jp/doc_root/ja/user_guides/FugakuSpackGuide/intro.html#os
#Known issue: Path of dynamic link libraries of the operating system
export LD_LIBRARY_PATH=/lib64:$LD_LIBRARY_PATH

export EMSES_DEBUG=no

date

rm *_0000.h5
mpiexec ./mpiemses3D plasma.inp
```

`#PJM -L  "node=4"`: 4ノードを使用する

富岳には1ノードあたり1CPUあり、1CPUあたり48コアある。EMSESではMPIプロセス並列を利用するため、プロセス数/48の切り上げがノード数になる。このシミュレーション条件では128プロセスを使用するため、128/48=2.67なので最低3ノードを使用する。
ただし、富岳はノードあたりのメモリが32GBであるため、メモリが足りない場合はノード数を増やす必要がある。本条件では32GB*3=96GBで足りないため、4ノードを使用する。

`#PJM --mpi proc=128`: MPIプロセス数を128に設定する

`#PJM -L  "rscgrp=small"`: リソースグループをsmallに設定する

ノード数が384以下のジョブはsmallに設定する。ほとんどのジョブはsmallに設定すればよい。

`#PJM -L  "elapse=10:00:00"`: ジョブの実行時間を10時間に設定する

リソースグループがsmallの場合、ジョブの実行時間は最大で72時間である。実行時間を長くするとキューに投入してから実行されるまでが長くなるため、必要以上に長い時間を設定しないようにする。
例えば、プログラムが正しく動作するか確認したい場合は10分程度の短い時間を設定するのがよい。

`#PJM -x PJM_LLIO_GFSCACHE=/vol0004`: spackを使用する場合に指定する
富岳の計算ノードからspackを使用してライブラリを読み込むとき指定する必要がある。

`#PJM -g hp240400`: グループ名を指定する


```
#loading modules
. /vol0004/apps/oss/spack/share/spack/setup-env.sh
spack load /yhazdvl
spack load /upvlzyl
```

モジュールのロードを行う。
富岳にはモジュールが多く用意されているためこのスクリプトではモジュールの名前とバージョンのハッシュ値を指定している。

`export LD_LIBRARY_PATH=/lib64:$LD_LIBRARY_PATH`
富岳で現在発生している「OS標準の動的ライブラリパスが上書きされる問題」に対処している。

`mpiexec ./mpiemses3D plasma.inp`
MPIプロセスの実行は`mpiexec`コマンドを使用する。SLURMではないので`srun`コマンドは使わない。

### ジョブの投入と確認

富岳では富士通のジョブスケジューリングシステム(PJM)を使用している。

ジョブの投入は`pjsub`コマンドを使う。

ジョブの確認は`pjstat`コマンドを使う。

`pjsub`コマンドを実行するときのカレントディレクトリがジョブ(スクリプト)の実行ディレクトリになるので注意する。

富岳にはSLURMのコマンドもあるが、プリポスト環境用なので使わないようにする。

参考文献
[1] https://www.hpci-office.jp/application/files/3116/9448/3951/r06a_fugaku_seminar_system.pdf
