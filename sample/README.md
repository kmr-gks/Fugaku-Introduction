### サンプルコードについて

### 目次

-[目次](#目次)

-[サンプルコードの動かし方](#サンプルコードの動かし方)

### サンプルコードの動かし方

#### hdf5

#### コンパイル方法

ログインノードで以下のスクリプトを実行する
例:

```
cd sample/hdf5
./hdftest-mpifccpx.sh
```


##### hdftest-longinintel.sh

intel oneAPIを使用し、ログインノードで実行可能なバイナリを生成する。

##### hdftest-mpifccpx.sh

富士通製コンパイラを使用し、Cのコードから計算ノードで実行可能なバイナリを生成する。

##### hdftest-mpifrtpx.sh

富士通製コンパイラを使用し、Fortranのコードから計算ノードで実行可能なバイナリを生成する。

#### 実行方法

```
cd sample/hdf5
pjsub -g <group id> ./hdftest-job.sh
```

