#!/bin/bash

CURRDIR=`pwd`
SCRIPTDIR=$(cd `dirname $0` && pwd)

# Create Links
cd ~
ln -s $SCRIPTDIR/aliases .aliases
ln -s $SCRIPTDIR/gitconfig .gitconfig
ln -s $SCRIPTDIR/spacemacs .spacemacs
ln -s $SCRIPTDIR/zshenv .zshenv
ln -s $SCRIPTDIR/zshrc .zshrc
ln -s $SCRIPTDIR/hammerspoon .hammerspoon
ln -s $SCRIPTDIR/psqlrc .psqlrc
ln -s $SCRIPTDIR/vim .vim
ln -s $SCRIPTDIR/nvim .config/nvim
ln -s $SCRIPTDIR/iterm2 .iterm2
ln -s $SCRIPTDIR/lein .lein
ln -s $SCRIPTDIR/zprezto .zprezto
ln -s $SCRIPTDIR/zpreztorc .zpreztorc
ln -s $SCRIPTDIR/zlogin .zlogin
ln -s $SCRIPTDIR/zlogout .zlogout
ln -s $SCRIPTDIR/zprofile .zprofile
ln -s $SCRIPTDIR/ideavimrc .ideavimrc
ln -s $SCRIPTDIR/karabiner .config/karabiner
ln -s $SCRIPTDIR/stylelintrc .stylelintrc
ln -s $SCRIPTDIR/starship.toml .config/starship.toml
ln -s $SCRIPTDIR/bat .config/bat
ln -s $SCRIPTDIR/kitty.conf .config/kitty/kitty.conf
