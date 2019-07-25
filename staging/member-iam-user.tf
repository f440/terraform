## users
module "iam-user-naito" {
  source         = "./modules/iam/users"
  name           = "naito"
}

module "iam-user-fujimura" {
  source         = "./modules/iam/users"
  name           = "fujimura"
}

module "iam-user-hikita" {
  source         = "./modules/iam/users"
  name           = "hikita"
}

## groups
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
    "${module.iam-user-naito.name}",
    "${module.iam-user-fujimura.name}",
  ]
}

### developers
module "iam-group-developer" {
  source = "./modules/iam/groups"
  name   = "developer"

  users = [
    "${module.iam-user-hikita.name}",
  ]
}
