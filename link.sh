if [[ $1 == 'astro' ]]; then
  ln -s ${HOME}/.config/nvim/lua/user/ftplugin ${HOME}/.config/nvim/
elif [[ $1 == 'nvchad' ]]; then
  ln -s ${HOME}/.config/nvim/lua/custom/ftplugin ${HOME}/.config/nvim/
fi
