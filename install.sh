#!/bin/bash

PATH=/usr/bin

# local config
ln -s ~/.dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/ansible.cfg ~/.ansible.cfg
ln -s ~/.dotfiles/hgrc ~/.hgrc
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/gitignore ~/.gitignore
ln -s ~/.dotfiles/gdbinit ~/.gdbinit
ln -s ~/.dotfiles/ansible.cfg ~/.ansible.cfg
ln -s ~/.dotfiles/gpg.conf ~/.gnupg/gpg.conf

# security related
if [[ -e ~/.ssh && ! -e ~/.ssh/config ]]; then
    cp ~/.dotfiles/ssh_config ~/.ssh/config
    mkdir ~/.ssh/sockets
fi

cat << EOF
for nftables firewall (as root):
  cp ~/.dotfiles/firewall/workstation.nftables /etc/nftables.conf
  vim /etc/nftables.conf
  systemctl start nftables
  systemctl enable nftables
EOF

# advanced tooling
[[ ! -e ~/.newsboat ]] && mkdir ~/.newsboat
ln -s ~/.dotfiles/newsboat.cfg ~/.newsboat/config

cd ~/.dotfiles && git submodule update --init
