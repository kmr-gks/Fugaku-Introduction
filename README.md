# Fugaku-Introduction

### スーパーコンピュータ「富岳」の使い方

### 目次

-[目次](#目次)
-[接続前の設定](#接続前の設定)
-[ストレージについて](#ストレージについて)
-[モジュールについて](#モジュールについて)

### 接続前の設定

まず、理研から届くメールに添付されている証明書をインストールする

公式ページ([https://www.fugaku.r-ccs.riken.jp/](https://www.fugaku.r-ccs.riken.jp/))に接続できるか確認する。

[ユーザーポータル](https://www.fugaku.r-ccs.riken.jp/user_portal/#/publickey_registration)から公開鍵を登録する。

SSHの設定をする

```
Host fugaku
	HostName login.fugaku.r-ccs.riken.jp
	User (user name)
	IdentityFile ~/.ssh/id_rsa_cs
```

### ストレージについて

富岳にはホームディレクトリ/データディレクトリ/シェアディレクトリ/tmpfsディレクトリ/2ndfsディレクトリの5つのファイルシステムがある。

ホームディレクトリ(~)には20GBの容量制限があるため注意する。

使用量は[ここ](https://ondemand.fugaku.r-ccs.riken.jp/pun/sys/Disk_Info)で確認できる。

私はホームディレクトリに2ndfsディレクトリへのシンボリックリンクを作成して運用しています。

```
ln -s /2ndfs/(group name)/(your dir name) ~/(link name)
```

`(group name)`はアカウント登録時に割り当てられたグループ名(例: hp999999)。

### モジュールについて
