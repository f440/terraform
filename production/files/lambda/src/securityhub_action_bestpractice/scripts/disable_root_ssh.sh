#!/bin/bash

set -xe

echo '[*] Backup current sshd_config'
CONFIG_BACKUP=sshd_config.$(date +%Y%m%d%H%M%S)
cp -p /etc/ssh/sshd_config /etc/ssh/$CONFIG_BACKUP

echo '[*] Update sshd_config'
sed -i -e '/^PermitRootLogin/s/^/#/' -e '$a PermitRootLogin no' /etc/ssh/sshd_config

echo '[*] Restart sshd service'
systemctl restart sshd || (
  echo '[*] Restarting sshd failed. Revert to original config'
  cp -p /etc/ssh/$CONFIG_BACKUP /etc/ssh/sshd_config
  systemctl restart sshd
)
