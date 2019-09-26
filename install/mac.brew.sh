#! bash

# install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor # has errors

# use GNU utils should before setting up common dotfiles
brew install coreutils  # GNU version of core utils (ls, cat, ..) https://www.gnu.org/software/coreutils
brew install moreutils  # extras like parallel https://joeyh.name/code/moreutils/  https://rentes.github.io/unix/utilities/2015/07/27/moreutils-package/
brew install --force parallel
brew link --overwrite parallel
brew install findutils  # locate, updatedb, find, xargs  https://www.gnu.org/software/findutils/
brew install gnu-sed     # GNU sed is not part of coreutils
brew install gnu-tar
brew install grep
brew install gawk
brew install gnutls gnu-indent gnu-getopt

brew install git
# manual steps
# git clone common
# setup manual dotfiles

brew install pv          # pipe visuzlizer
brew install tldr        # https://github.com/tldr-pages/tldr
brew install watch       # periodic command execution
brew instal htop
brew install wget --with-debug

# generic mac/bash setup
brew install python3
brew install mas         # Mac App Store command line
brew install autojump
brew install shellcheck  # (+ vscode ext)
brew install micro       # https://github.com/zyedidia/micro
brew install hh          # https://github.com/dvorka/hstr

brew install ctags       # to have Cmd+T (tag search) in vscode working

# https://github.com/junegunn/fzf
brew install fzf
/usr/local/opt/fzf/install # Install shell extensions

# data science setup
pip3 install csvkit
brew install xcv
brew install miller
brew install jq
brew install pup     # https://github.com/EricChiang/pup
brew install q       # https://github.com/harelba/q

# gitsome - https://github.com/donnemartin/gitsome/issues/4
conda install python=3.5 # gitsome doesn't support python 3.6 yet
pip3 install gitsome # still fails :(
# manual install:
git clone https://github.com/donnemartin/gitsome.git
cd gitsome/
pip install -e .


======= jupyter ========
# R-kernel
# installing R-kernel, if doesnt work try this: had a similar issue. My solution was to add .libPaths(pathVectorVariable) to the file "Rprofile.site" such that the executable R.exe had access to the packages installed through RStudio. Here "pathVectorVariable" is just the vector of path strings where you have your packages installed.
# https://github.com/IRkernel/IRkernel/issues/167

# Jupyter bash_kernel - https://github.com/takluyver/bash_kernel
pip install bash_kernel
python -m bash_kernel.install
