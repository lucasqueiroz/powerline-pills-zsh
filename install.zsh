#!/usr/bin/env zsh
#
# Author: Lucas Queiroz
# https://github.com/lucasqueiroz/powerline-pills-zsh

echo ""
print -P -- "%f%k%F{2}%K{2}%F{7} Installing %F{2}%K{8}%F{7} Powerline %F{8}%K{9}%F{7} Pills %k%F{9}%F{7}"
echo ""

Exports current folder to ~/.zshrc
echo -e "# Powerline Pills Theme" >> $HOME/.zshrc
variable="export POWERLINE_PILLS=\"$PWD\""
echo -e "$variable" >> $HOME/.zshrc

# TODO COPY THEME FILE

print -P -- "%f%k%F{2}%K{2}%F{7} Installed! %k%F{2}%F{7}"
echo ""