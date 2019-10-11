## groups
#
# 下記の設定内容を実施する
# * バックエンドは基本的に「developer」グループに所属すること
# * フロントエンドは「frontend」グループに所属すること
# * QA/SETは「qa」グループに所属すること
# * ジュニアメンバーは「junior」グループに所属すること
#
# administrator:
#   * 開発アカウント: 無制限
#   * 本番アカウント: 無制限 に切り替えられる
# developer:
#   * 開発アカウント: 無制限
#   * 本番アカウント: developer role (ReadOnly) に切り替えられる
# qa:
#   * 開発アカウント: 無制限
#   * 本番アカウント: developer role (ReadOnly) に切り替えられる
# frontend:
#   * 開発アカウント: 無制限
#   * 本番アカウント: 切り替えられない

### administrator
module "iam-group-administrator" {
  source = "./modules/iam/groups"
  name   = "administrator"

  users = [
    "${module.iam-user-naito-kensuke.name}",
    "${module.iam-user-serizawa.name}",
    "${module.iam-user-munehiko-fujimura.name}",
    "${module.iam-user-takumi-kanzaki.name}",
    "${module.iam-user-takuya-morizumi.name}",
    "${module.iam-user-teppi-fujii.name}",
    "${module.iam-user-motoki-sato.name}",
    "${module.iam-user-mutsuhisa-suzuki.name}",
    "${module.iam-user-takeo-kimi.name}",
    "${module.iam-user-yoshinari.name}",
    "${module.iam-user-yoshio-fuse.name}",
    "${module.iam-user-yusuke-karakita.name}",
    "${module.iam-user-yasuhiro-kinoshita.name}",
    "${module.iam-user-kazuma-watanabe.name}"
  ]
}

### developer
module "iam-group-developer" {
  source = "./modules/iam/groups"
  name   = "developer"

  users = [
    "${module.iam-user-shun-hikita.name}",
    "${module.iam-user-shogo-hashimoto.name}",
    "${module.iam-user-risa-watanabe.name}",
    "${module.iam-user-takashi-yasuma.name}",
    "${module.iam-user-wataru-miyaguni.name}",
  ]
}

### frontend
module "iam-group-frontend" {
  source = "./modules/iam/groups"
  name   = "frontend"

  users = [
    "${module.iam-user-atsushi-mizoue.name}",
    "${module.iam-user-hiroki-watanabe.name}",
    "${module.iam-user-shota-takata.name}",
  ]
}

### qa
module "iam-group-qa" {
  source = "./modules/iam/groups"
  name   = "qa"

  users = [
    "${module.iam-user-muga-tairaku.name}",
  ]
}
