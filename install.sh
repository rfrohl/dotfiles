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
[[ -e ~/.ssh && ! -e ~/.ssh/config ]] && cp ~/.dotfiles/ssh_config ~/.ssh/config

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
