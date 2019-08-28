function freshie -d 'Update fish plugins, dotfiles symlinks and homebrew packages'

  # init/update git submodules as needed
  echo "updating dotfile submodules"
  pushd (find_dotfiles)
  git submodule init
  git submodule update
  popd

  # redeploy any symlinks from dotfiles
  echo "restowing dotfile symlinks"
  deploy_stow

  echo "updating and upgrading all brew packages"
  brew update
  and brew upgrade
  brew cleanup

  echo "rehashing rbenv"
  rbenv rehash

  echo "setting goroot"
  set_goroot
end
