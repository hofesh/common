#! bash

# links
# https://unix.stackexchange.com/questions/31161/quick-directory-navigation-in-the-bash-shell


============= File Search Applications =============

## Finder
# During search - type "name:" for path only matching excluding content  
# Cmd+Shift+G (open path bar in finder or open/save dialog)

## Alfred
# Open Alfred (Alt+Space) then type "'"


## EasyFind


============= file search with bash =============

# find
find / 2> /dev/null -name "*data*"

# locate
locate data
updatedb

# mdfind
mdfind -name some thing
spot data
goto some.file  # "spot" file and cd to it's dir

# fzf
brew install fzf
/usr/local/opt/fzf/install
Ctrl+T   # search for file and paste inline
Alt+C    # search for folder and cd into it
# examples (spot, ll -R, curl -L ..)


============= Directories Navigation =============

# tree
tree            # dirs and files in current path
tree -d path    # dirs only in path

# cd
cd -            # go to previous dir

## cd -- (install acd_func.sh)
cd --           # show last the visited dirs
cd ~5           # cd to the 5th entry
cv -5           # same

## CDPATH (ENV VAR)
CDPATH=:..:~:~/git

## fasd https://github.com/clvv/fasd
brew install fasd
f foo           # list frecent files matching foo
d foo           # list frecent dirs matching foo
a foo bar       # list frecent files and directories matching foo and bar
f js$           # list frecent files that ends in js
f -e code foo   # run code on the most frecent file matching foo
code `f bar`    # run code on the most frecent file matching bar
z foo           # cd into the most frecent directory matching foo
open `sf pdf`   # interactively select a file matching pdf and launch `open`
# Alternative: z, autojump (j), xd

# ranger
brew install ranger
ranger
