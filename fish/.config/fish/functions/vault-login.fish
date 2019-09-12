function vault-login
  kubectl login $argv[1] --vault-only
  bass eval (kubectl vault print-auth)
  echo $VAULT_TOKEN | envchain --set $VAULT_ADDR VAULT_TOKEN
end

