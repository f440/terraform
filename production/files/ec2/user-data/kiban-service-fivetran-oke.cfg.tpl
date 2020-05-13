#cloud-config
timezone: "Asia/Tokyo"
bootcmd:
  - yum -y groupinstall "@Development tools"
  - groupadd fivetran
  - useradd -m -g fivetran fivetran
  - sudo mkdir /home/fivetran/.ssh
  - sudo chmod 700 /home/fivetran/.ssh
  - sudo chown -R fivetran:fivetran /home/fivetran/.ssh
packages:
  - gcc
  - gcc-c++
  - dstat
  - sysstat
  - iotop
  - jq
  - git
  - htop
  - readline-devel
  - libffi-devel
  - zlib-devel
  - lsof
  - strace
  - tree
write_files:
  - content: |
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCOCjfNWX9thpg9C7YpswLFa/bZxHTNrXRSgOzca1uag1HSZ4lHliZG+bMAKW8GXE/LMsIMYXFucXuNOdxs5qDlOiXk1d+C8Xif2BV4pMC6BR32WK1reHp2nm97h+2/LANxAnIit+e1SA5z6e66cClyEqDV6JEfbCGk4hsjMkacw0jqVnTPGigEoA2g6d8cBz1eDb2Xgb0Z8VUuVXaGbI6OliUbq6vhagoEA/Bqht0UCQNnapd4skRSkAt7QbR3d4fByAXPs53d5yqWy+otgxZEHEwiesrlXzULc34CUDGUYIcUy/K2qZGMt7r6DwVHo23SS502Ps8PlJenZ5FTD8zwc/djklpHPiIBsc9inA+3tz2ilvhfDLdBCcW42RcUIU2nzDDR2cVthdNH2RbiQjmPn7qoawX/0bHJocPOv8USD8USphwVf6YsXPX7kduuE84hWTzLjkNJAf2yAIV+qvw1mznL2UuqkaY/09ESmiPJuPob70f+sjUxuw4+/+imf/2ad9poshZDF7gENtOJxchjS0xGRiEaO0+rzhY24F6g84TGCvp2RUQkz8tsXOOUALAnii6mIT24R6aKXxqvCv2NrLCaQLagTlW8bL197kxAhIMF9HcfI7dOdzLc8y9SUeJkIL3x5bOqi/m+tbJbgDOh4gpKZ7HTfejCZ7w9PobHpw== fivetran user key
    owner: fivetran:fivetran
    path: /home/fivetran/.ssh/authorized_keys
    permissions: '0600'
  - content: |
      export PATH=/usr/pgsql-10/bin:$PATH
    owner: root:root
    path: /etc/profile.d/postgresql.sh
    permissions: '0644'
runcmd:
  - yum install -y https://yum.postgresql.org/10/redhat/rhel-7-x86_64/postgresql10-libs-10.12-1PGDG.rhel7.x86_64.rpm
  - yum install -y https://yum.postgresql.org/10/redhat/rhel-7-x86_64/postgresql10-10.12-1PGDG.rhel7.x86_64.rpm
  - yum install -y https://yum.postgresql.org/10/redhat/rhel-7-x86_64/postgresql10-devel-10.12-1PGDG.rhel7.x86_64.rpm
  - yum install -y https://yum.postgresql.org/10/redhat/rhel-7-x86_64/postgresql10-contrib-10.12-1PGDG.rhel7.x86_64.rpm
