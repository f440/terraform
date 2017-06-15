## やりたいこと

```
（例）
{{誰}}の{{課題の内容}}という課題を解決したい
```

## やったこと

```
（例）
- route53のrecordを追加した
```

## terraform plan の実行結果

```
（例）
-> % terraform plan

Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

aws_route53_record.db-local-daruma-space-CNAME: Refreshing state... (ID: Z2IE6RW5PM57F5_db.local.daruma.space_CNAME)
aws_route53_record.y-knot-jp-MX: Refreshing state... (ID: Z39M8SG96Z7R1L_y-knot.jp_MX)
No changes. Infrastructure is up-to-date.

This means that Terraform did not detect any differences between your
configuration and real physical resources that exist. As a result, Terraform
doesn't need to do anything.

```

## 関連リンク

```
（例）
- JIRA の URL
- StackOverflow や Qiita の URL
```


## マージ後にやること

```
（例）
- terraform を適用する必要がある場合のみ
- `terraform plan`
- `terraform apply`
```
