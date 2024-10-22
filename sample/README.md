### サンプルコードについて

### 目次

-[目次](#目次)

-[サンプルコードの動かし方](#サンプルコードの動かし方)
	-[コンパイル方法](#コンパイル方法)
	-[実行方法](#実行方法)
	-[hdf5](#hdf5)
	-[fftw](#fftw)
	-[現在の動作条件](#現在の動作条件)

### サンプルコードの動かし方

#### コンパイル方法

ログインノードで以下のスクリプトを実行する
例:

```
cd sample/hdf5
./hdf-fcc.sh
```

#### 実行方法

```
cd sample/hdf5
pjsub -g <group id> hdf-job.sh
```

#### hdf5

##### hdf-fcc.sh/hdf-frt.sh

富士通製コンパイラ(`mpifccpx`/`mpifrtpx`)を使用し、C/Fortranのコードから計算ノードで実行可能なバイナリを生成する。

##### hdf-intel.sh

intel oneAPI(`icpx`/`ifx`)を使用し、ログインノードで実行可能なバイナリを生成する。

##### hdf-gnu-arm.sh

gnuコンパイラ(`gcc`/`gfortran`)でコンパイルし、`mpifccpx`を使用してリンクし、計算ノードで実行可能なバイナリを生成する。
gnuコンパイラと富士通MPIを組み合わせる[クロスコンパイル](https://www.fugaku.r-ccs.riken.jp/doc_root/ja/user_guides/lang_latest/CompileforCN/`gcc`_MPI/index.html#id2)を行う。

##### hdf-gnu-x86.sh

gnuコンパイラ(`gcc`/`gfortran`)でコンパイルとリンクを行い、ログインノードで実行可能なバイナリを生成する。

#### fftw

##### fftw-fcc.sh/fftw-frt.sh

富士通製コンパイラ(`mpifccpx`/`mpifrtpx`)を使用し、C/Fortranのコードから計算ノードで実行可能なバイナリを生成する。

##### fftw-intel.sh

intel oneAPI(`icpx`/`ifx`)を使用し、ログインノードで実行可能なバイナリを生成する。

##### fftw-gnu-arm.sh

gnuコンパイラ(`gcc`/`gfortran`)でコンパイルし、`mpifccpx`を使用してリンクし、計算ノードで実行可能なバイナリを生成する。
gnuコンパイラと富士通MPIを組み合わせる[クロスコンパイル](https://www.fugaku.r-ccs.riken.jp/doc_root/ja/user_guides/lang_latest/CompileforCN/`gcc`_MPI/index.html#id2)を行う。

##### fftw-gnu-x86.sh

gnuコンパイラ(`gcc`/`gfortran`)でコンパイルとリンクを行い、ログインノードで実行可能なバイナリを生成する。

#### 現在の動作条件

hdf5ライブラリを使用するC/Fortranコードが正しくコンパイルできる処理系は

* 富士通コンパイラ

である。fftwライブラリを使用するC/Fortranコードが正しくコンパイルできる処理系は

* gnuコンパイラ(ログインノード向け)
* 富士通コンパイラ
* intel oneAPI

である。これら以外の処理系でコンパイルすると、CコードはコンパイルできるがFortranコードでエラーが発生する。エラーメッセージはhdf5/fftwライブラリが見つからないという内容や、GNUでコンパイルしたオブジェクトファイルと富士通MPIでのクロスコンパイル時に正しくリンクできないという内容である。
