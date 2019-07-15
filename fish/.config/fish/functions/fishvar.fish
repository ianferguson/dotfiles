function fishvar -d 'Mostly translate Bash var sets to fishy forms you can eval (echo $bash) on'
  eval ($argv) | sed -e 's/^/set /' -e 's/export/-x/' -e 's/=/ /g' | tr '\n' ';'
end

