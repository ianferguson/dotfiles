function vault-vault
  set -q VAULT_ADDR; or echo "VAULT_ADDR must be set"
  echo $VAULT_ADDR
  envchain $VAULT_ADDR vault $argv
end

