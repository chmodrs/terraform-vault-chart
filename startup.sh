#!/bin/sh

sed -i -e "s~VAULT_SECRET_KEY~$VAULT_SECRET_KEY~g" vault.tf
sed -i -e "s/VAULT_ACCESS_KEY/$VAULT_ACCESS_KEY/g" vault.tf
sed -i -e "s/VAULT_BUCKET/$VAULT_BUCKET/g" vault.tf
sed -i -e "s/VAULT_KMS_ID/$VAULT_KMS_ID/g" vault.tf


rm -rf .terraform
terraform --version
terraform init -backend-config "bucket=cloudtech-terraform-tfstate" -backend-config "region=sa-east-1" -backend-config "key=pgmbox-vault"

if [[ $(terraform workspace list | grep 'production' | wc -l ) = 0 ]]; then
  terraform workspace new production
fi
terraform workspace select production