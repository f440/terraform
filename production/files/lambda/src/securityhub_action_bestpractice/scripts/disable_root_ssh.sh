#!/bin/bash

set -xe
cp -p /etc/ssh/sshd_config /etc/ssh/sshd_config.$(date +%Y%m%d%H%M%S)
sed -i -e '/^PermitRootLogin/s/^/#/' -e '$a PermitRootLogin no' /etc/ssh/sshd_config
systemctl restart sshd
