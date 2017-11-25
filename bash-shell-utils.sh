#!bash

# xcv - copy paste files
xcv c file.dat          # copy
cd some/other/path      # or in another shell
xcv v                   # paste

# hh
brew install hh

# ShellShock
brew install shellcheck # Also install VS Code ext'

# TL;DR
brew install tldr
# Demo:
tldr sed
tldr xargs

## fasd https://github.com/clvv/fasd
brew install fasd

# micro editor
brew install micro
micro file.txt


# pipe visualizer
brew install pv
seq 1000000000 | pv > /dev/null
seq 1000000000 | pv -cN seq | gzip | pv -cN gzip > /dev/null


# fzf
brew install fzf
history | fzf
find . -name *.js | fzf
ll -R | fzf
# Shell extensions
/usr/local/opt/fzf/install
Ctrl+R   # fzf history search
Ctrl+T   # search for file and paste inline
Alt+C    # search for folder and cd into it


## gitsome

# rsub
sudo yum install wget
sudo wget -O /usr/local/bin/rsub https://raw.github.com/aurora/rmate/master/rmate; sudo chmod a+x /usr/local/bin/rsub

# install python27 on redhat
# https://tecadmin.net/install-python-2-7-on-centos-rhel/
# make python27 the default python
sudo ln -sf /usr/bin/python27 /usr/local/bin/python
# install pip
# https://stackoverflow.com/questions/26266437/how-to-use-python2-7-pip-instead-of-default-pip
# https://packaging.python.org/tutorials/installing-packages/
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py --prefix=/usr/local/

# http server for current dir
# https://askubuntu.com/questions/377389/how-to-easily-start-a-webserver-in-any-folder
python2 -m SimpleHTTPServer
python3 -m http.server
