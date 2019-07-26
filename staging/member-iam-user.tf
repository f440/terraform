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
