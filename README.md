# terraform
Terraform for SmartHR

## これは何

AWS環境の環境をコードで管理しているもの
terraformでよく使うであろうコマンドをラップしたshellがありますのでそちらを使って反映してください

## インストール

動作対象の terraform バージョンは .terraform-version を参照。
tfenv をいれるとスムーズ。

```
$ brew install tfenv
$ cd kufu/terraform
$ tfenv install
```

## 実行方法

適用したいサービスを選択する方式を採用しています

```
$bash terraform.sh format
Please select service to apply terraform
0 : cloudflare
1 : production
Select AWS Service Number > 1

<実行ログの表示>
```

## 初回もしくはprovider追加時

```
$ bash terraform.sh init
```

## AWS環境への適用内容を確認

```
$ bash terraform.sh plan
```

## AWS環境への適用

```
$ bash terraform.sh apply
```

## ファイルのフォーマット調整

```
$ bash terraform.sh format
```

## import

terraformのオプションがそのまま引き渡せます

```
$ bash terraform.sh import aws_elasticache_parameter_group.plus-ayatori-redis-32 ayatori-redis-32
```
