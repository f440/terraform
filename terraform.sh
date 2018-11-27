#!/bin/bash

set -e

declare -r TERRAFORM_VERSION=v0.11.10
declare -r TERRAFORM_PLAN_PATH=.terraform/terraform.plan
declare -r TERRAFORM_TFSTATE_PATH=.terraform/terraform.tfstate

function usage() {
    echo "***** usage *****"
    echo "bash terraform.sh init                       : initialize terraform configuration."
    echo "bash terraform.sh apply                      : apply aws configuration."
    echo "bash terraform.sh import <RESOURCE> <VALUE>  : import aws configuration RESOURCE & VALUE."
    echo "bash terraform.sh remove-resource <RESOURCE> : remove aws configuration RESOURCE."
    echo "bash terraform.sh show                       : show aws configurated status."
    echo "bash terraform.sh plan                       : show aws configuration plan."
    echo "bash terraform.sh format                     : format terraform files."
}

function is_installed_version() {
    if [ -z $(which terraform) ]; then
        echo "install terraform ${TERRAFORM_VERSION}"
        exit
    fi
    is_version=$(terraform --version | grep $TERRAFORM_VERSION)
    if [[ -z $is_version ]]; then
        echo "install terraform ${TERRAFORM_VERSION}"
        exit
    fi
}

function init() {
    terraform init && terraform get
}

function apply() {
    plan

    /bin/echo -n "confirm[Y/n] > "
    read CONFIRM

    if [ "${CONFIRM}" != 'Y' ];then
        exit
    fi

    terraform apply $TERRAFORM_PLAN_PATH
}

function import() {
    terraform get && terraform state pull

    terraform import $1 $2
}

function remove-resource() {
    if [ -z "${1}" ]; then
        echo "invalid argument."
        exit
    fi
    terraform get && terraform state pull

    terraform state rm $1
}

function show() {
    terraform show $TERRAFORM_TFSTATE_PATH
}

function plan() {
    terraform plan -out $TERRAFORM_PLAN_PATH && echo ""
}

function format() {
    terraform fmt -diff=true .
}

function validate() {
    terraform validate .
}

function _main() {
    is_installed_version

    # selectorに表示されて困るディレクトリを除外
    echo "Please select service to apply terraform"
    aws_services=($(find . -type d -name '.git*' -prune -o -type d -maxdepth 1 -mindepth 1 -print| awk -F/ '{print $NF}'))

    ITER=0
    for service in ${aws_services[@]}
    do
        echo "${ITER} : ${service}"
        ITER=$(expr $ITER + 1)
    done
    echo -n "Select AWS Service Number > "
    read service_number
    selected_service=${aws_services[$service_number]}

    cd $selected_service
    case $1 in
        "init")
            init;;
        "apply")
            apply;;
        "import")
            import $2 $3;;
        "remove-resource")
            remove-resource $2;;
        "show")
            show;;
        "plan")
            plan;;
        "format")
            format;;
        "validate")
            validate;;
        *)
            usage
    esac
}

_main $1 $2 $3
