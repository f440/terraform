## groups
#
# 下記の設定内容で、基本は「developer」グループに所属すること
#
# developer:
#   * 開発アカウント: 無制限
#   * 本番アカウント: developer role (delete 系以外は実行可能) に切り替えられる
# administrator:
#   * 開発アカウント: 無制限
#   * 本番アカウント: 無制限 に切り替えられる

### administrator
module "iam-group-administrator" {
  source = "./modules/iam/groups"
  name   = "administrator"

  users = [
    "${module.iam-user-munehiko-fujimura.name}",
  ]
}

### developers
module "iam-group-developer" {
  source = "./modules/iam/groups"
  name   = "developer"

  users = [
    "${module.iam-user-naito-kensuke.name}",
    "${module.iam-user-test-naito.name}"
  ]
}
