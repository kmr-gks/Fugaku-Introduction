# Fugaku-Introduction

### スーパーコンピュータ「富岳」の使い方

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
