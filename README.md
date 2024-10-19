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

### サンプルコード

富岳公式のサンプルコードは `/home/system/sample`にある。

### ジョブの投入と確認

ジョブの投入は`pjsub`コマンドを使う。

ジョブの確認は`pjstat`コマンドを使う。

`pjsub`コマンドを実行するときのカレントディレクトリがジョブ(スクリプト)の実行ディレクトリになるので注意する。

私の環境では、スクリプト内でスクリプトファイルのある場所をカレントディレクトリに設定してもうまくディレクトリが変更されませんでした。
