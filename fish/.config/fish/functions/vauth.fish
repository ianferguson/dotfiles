function vauth
  set -ge VAULT_TOKEN
  set -Ue VAULT_TOKEN
  vault auth -method=ldap username=ian.ferguson
  set -Ux VAULT_TOKEN (cat ~/.vault-token)
end
