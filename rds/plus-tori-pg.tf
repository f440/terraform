resource "aws_db_parameter_group" "ayatori-dbparamgroup" {
  name   = "ayatori-dbparamgroup"
  family = "postgres10"

  description = "PostgreSQL 10 Parameter Groups for ayatori"
}

resource "aws_db_parameter_group" "kotori-dbparamgroup" {
  name   = "kotori-dbparamgroup"
  family = "postgres10"

  description = "PostgreSQL 10 Parameter Groups for kotori"
}

resource "aws_db_parameter_group" "shiritori-dbparamgroup" {
  name   = "shiritori-dbparamgroup"
  family = "postgres11"

  description = "PostgreSQL 11 Parameter Groups for shiritori"
}

resource "aws_db_parameter_group" "sekitori-dbparamgroup" {
  name   = "sekitori-dbparamgroup"
  family = "postgres11"

  description = "PostgreSQL 11 Parameter Groups for sekitori"
}
