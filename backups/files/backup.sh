#!/bin/bash

DIRS='/home/azx/Projects/notes /home/azx/pass'
STORAGE=/home/azx/backups

VAULT_PASS_PATH=/home/azx/Projects/dotfiles/ansible_pass.txt
BACKUP_PASS_PATH=/home/azx/Projects/dotfiles/backups/vars/pass.yml

PASSWORD=$(ansible-vault view $BACKUP_PASS_PATH --vault-password-file=$VAULT_PASS_PATH)

timestamp="$(date +"%Y%m%d_%H%M%S")"
tar -cvf - $DIRS | gzip -9 > "${STORAGE}/${timestamp}.tar.gz"
openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -salt -in "${STORAGE}/${timestamp}.tar.gz" -out "${STORAGE}/${timestamp}.tar.gz.enc" -k $PASSWORD

echo "${STORAGE}/${timestamp}.tar.gz.enc done"

rm "${STORAGE}/${timestamp}.tar.gz"
