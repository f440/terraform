## users
#
# 前提:
#   * このファイルには、アカウントマスターとするため正社員だけを記載すること
#   * herokuなど、別途ユーザを発行使いたい場合は、別途ファイルを作って用意すること
# 規約:
#   * 基本的に、IAMユーザーは社内メールアドレス「xxx@smarthr.co.jp」のうち
#     「xxx」にあたるローカル部分を使用する
#   * IAMユーザーの識別が必要なため、slack名称、渾名、名字のみの使用は禁止(メールアドレスが名字のみの場合除く)
#   * IAMユーザーの作成は、正社員のみとする(業務委託メンバーには発行しない)
module "iam-user-naito-kensuke" {
  source         = "./modules/iam/users"
  name           = "naito.kensuke"
}

module "iam-user-munehiko-fujimura" {
  source         = "./modules/iam/users"
  name           = "munehiko.fujimura"
}

module "iam-user-serizawa" {
  source         = "./modules/iam/users"
  name           = "serizawa"
}

module "iam-user-takumi-kanzaki" {
  source         = "./modules/iam/users"
  name           = "takumi.kanzaki"
}

module "iam-user-yoshio-fuse" {
  source         = "./modules/iam/users"
  name           = "yoshio.fuse"
}

module "iam-user-teppi-fujii" {
  source         = "./modules/iam/users"
  name           = "teppi.fujii"
}

module "iam-user-takuya-morizumi" {
  source         = "./modules/iam/users"
  name           = "takuya.morizumi"
}

module "iam-user-motoki-sato" {
  source         = "./modules/iam/users"
  name           = "motoki.sato"
}

module "iam-user-takeo-kimi" {
  source         = "./modules/iam/users"
  name           = "takeo.kimi"
}

module "iam-user-takashi-yasuma" {
  source         = "./modules/iam/users"
  name           = "takashi.yasuma"
}

module "iam-user-mutsuhisa-suzuki" {
  source         = "./modules/iam/users"
  name           = "mutsuhisa.suzuki"
}

module "iam-user-risa-watanabe" {
  source         = "./modules/iam/users"
  name           = "risa.watanabe"
}

module "iam-user-wataru-miyaguni" {
  source         = "./modules/iam/users"
  name           = "wataru.miyaguni"
}

module "iam-user-yoshinari" {
  source         = "./modules/iam/users"
  name           = "yoshinari"
}

module "iam-user-shun-hikita" {
  source         = "./modules/iam/users"
  name           = "shun.hikita"
}

module "iam-user-yusuke-karakita" {
  source         = "./modules/iam/users"
  name           = "yusuke.karakita"
}

module "iam-user-shogo-hashimoto" {
  source         = "./modules/iam/users"
  name           = "shogo.hashimoto"
}

module "iam-user-muga-tairaku" {
  source         = "./modules/iam/users"
  name           = "muga.tairaku"
}

module "iam-user-atsushi-mizoue" {
  source         = "./modules/iam/users"
  name           = "atsushi.mizoue"
}

module "iam-user-hiroki-watanabe" {
  source         = "./modules/iam/users"
  name           = "hiroki.watanabe"
}

module "iam-user-shota-takata" {
  source         = "./modules/iam/users"
  name           = "shota.takata"
}

module "iam-user-yasuhiro-kinoshita" {
  source         = "./modules/iam/users"
  name           = "yasuhiro.kinoshita"
}

module "iam-user-kazuma-watanabe" {
  source         = "./modules/iam/users"
  name           = "kazuma.watanabe"
}
