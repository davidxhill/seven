#!/usr/bin/env bash

echo "------ Setting VIM Preferences ------"
curl https://j.mp/spf13-vim3 -L > /home/vagrant/spf13-vim.sh
sudo su - vagrant -c 'sh /home/vagrant/spf13-vim.sh'
curl -o /home/vagrant/.vimrc.local https://raw.githubusercontent.com/davidxhill/mySettings/master/.vimrc.local
sudo chown -R vagrant:vagrant /home/vagrant/.vim
sudo chown -R vagrant:vagrant /home/vagrant/.vimrc*

if [[ -d "/home/vagrant/.vim/bundle/vim-colorschemes/colors/" ]]; then
    curl -o /home/vagrant/.vim/bundle/vim-colorschemes/colors/Peacock.vim https://raw.githubusercontent.com/davidxhill/mySettings/master/Peacock.vim
fi

sudo su - vagrant -c 'vim +BundleInstall +qall'

