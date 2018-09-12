#! bash

# install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor # has errors

# generic mac/bash setup
brew install python3
brew install mas         # Mac App Store command line
# GNU versions of core and more utils
brew install coreutils  # GNU version of core utils (grep, cat, ..)
brew install moreutils  # extras like parallel https://rentes.github.io/unix/utilities/2015/07/27/moreutils-package/
brew install findutils  # locate, updatedb, find, xargs
brew install gnu-sed     # GNU sed is not part of coreutils
brew install pv          # pipe visuzlizer
brew install shellcheck  # (+ vscode ext)
brew install tldr        # https://github.com/tldr-pages/tldr
brew install micro       # https://github.com/zyedidia/micro
brew install watch       # periodic command execution
brew install autojump
brew install hh          # https://github.com/dvorka/hstr
brew instal htop
brew install grep
brew install wget --with-debug


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
