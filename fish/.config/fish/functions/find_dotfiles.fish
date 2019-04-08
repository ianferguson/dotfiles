function find_dotfiles -d "Assume that fish config is actually managed in a git repo and find the root of that repo"
  echo (pushd (dirname "$HOME/.config/fish/"(readlink $HOME/.config/fish/config.fish)); and git_repository_root; popd)
end
