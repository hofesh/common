#! bash

# vim theme
cd ~/
mkdir .vim
cd .vim
mkdir colors
cd colors
curl -O https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim
cd ~/
#vim .vimrc
#! manual step here: https://www.hanselman.com/blog/SettingUpAShinyDevelopmentEnvironmentWithinLinuxOnWindows10.aspx


sudo apt update

# data-science

sudo apt install datamash
# sudo apt install miller # INSTALLS OLD VERISON !!


# general utils

sudo apt-get install xclip
sudo apt install mc # Midnight Commander
# https://github.com/ranger/ranger
# http://ranger.nongnu.org/cheatsheet.svg
sudo apt install ranger
# https://github.com/dustinkirkland/byobu
#! manual step for mouse support: https://askubuntu.com/questions/342845/can-i-use-mouse-click-to-focus-on-byobu-splits
sudo apt install byobu
sudo apt install jq
sudo pip3 install tldr # https://github.com/tldr-pages/tldr

# https://github.com/zyedidia/micro
go get -d github.com/zyedidia/micro/cmd/micro
cd $GOPATH/src/github.com/zyedidia/micro
make install

# https://github.com/donnemartin/gitsome
sudo pip3 install gitsome

# https://github.com/junegunn/fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# go lang
sudo apt install golang-go

# pup
go get github.com/ericchiang/pup
# or just download the pre-compiled linux-am64 release

# 
sudo apt install python3-pip
pip3 install --upgrade pip
pip3 install git+https://github.com/twosigma/ngrid

# increase swap-size
sudo swapoff -a
sudo dd if=/dev/zero of=/swapfile bs=1M count=8000
sudo mkswap /swapfile
sudo swapon /swapfile
