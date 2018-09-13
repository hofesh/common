#! bash

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
#alias -- -='cd -'                                          # -   aliased to:   cd -   (doesn't play well with env_parallel)
alias cd..='cd ..'                                          # catch typos

# command defaults
alias ls='ls -AF --show-control-chars --color=always'       # all, classify, ignore-case
alias ll='ls -FGAhl --show-control-chars --color=always'    # classify, ignore-case, no-group, all, human-readable, long-list
alias l="ll"
alias llt='ll -tr'                                         # list by last modified
alias lls='ll -Sr'                                         # list by size
alias md='mkdir -p'
alias vi="vim"                                                          # use vim by default
alias less="less -S"                                                    # less with no wordwrap
alias wcl="wc -l"

# utils
alias reload=". ~/.bashrc"
alias edit='eval "$EDITOR"'                                             # open default editor
alias cpwd="pwd | tr -d '\n' | pbcopy"                                  # copy current path to clipboard
alias cpcmd="history 2 | head -1 | sed 's/^ *[0-9]* *//' | pbcopy"      # copy last executed command
alias du1='du -h --max-depth=1 | sort -rh | less'                       # recursive folder sizes in current dir
alias du2='du -h --max-depth=2 | sort -rh | less'                       # recursive folder sizes in current dir
alias xbash='xargs -I__ bash --login -c'                                # xargs on bash strings
alias httpServer="python -m SimpleHTTPServer || python3 -m http.server" # local http server on curr dir
alias pathPrint='echo "$PATH" | tr ":" "\n"'
alias grepc="grep --color='always'"                                     # grep with color
alias lessc="less -r"                                                   # less with color 
alias hist="cat $historyLogPath/custom*"                                # show all custom history files
alias histfzf="cat $historyLogPath/custom* | fzf"                       # show all custom history files with fzf
alias revrows="rev"       # reverse chars in each line
alias revlines="tail -r"  # reverse order of lines
alias space="du -ha . | sort -rh | less" # find folders which take up most space
alias files="du --inodes -d 3 | sort -rh | less" # find folders with most files in them with recursive folders for given depth
alias files2="du --inodes -S | sort -rh | less" # find folders with most files in them

# search
alias fr='find / 2> /dev/null -iname '  # find root
alias fh='find . 2> /dev/null -iname '  # find here
alias f="fr"                            # f is by default find root

# git
alias g="git"
alias ga="git add"
alias gam="git add -u" # git add modified files only
alias gs="git status"
alias gd="git diff --color-words=."
alias gdt="git difftool"
alias gc="git commit"
alias gcm="git commit -m"
alias gcam="git commit -a -m"
alias gp="git push"
alias gpl="git pull --rebase"
alias gplr="git pull --rebase"
alias gplm="git pull --merge"
alias gco="git checkout"
alias grv="git remote -v"
#alias gl="git log --oneline --all --graph --decorate"
alias gl='git log --oneline --all --graph --pretty="%C(blue)%h%C(reset) %C(auto)%d%C(reset)- %an %C(green)(%ar)%C(reset) %s"'

# xcv cut/copy/paste
alias fsx="xcv x"   # cut
alias fsc="xcv c"   # copy
alias fsv="xcv v"   # paste
alias fsl="xcv l"   # list

# fasd auto-sets aliases:
#alias a='fasd -a'        # any
#alias s='fasd -si'       # show / search / select
#alias d='fasd -d'        # directory
#alias f='fasd -f'        # file
#alias sd='fasd -sid'     # interactive directory selection
#alias sf='fasd -sif'     # interactive file selection
#alias z='fasd_cd -d'     # cd, same functionality as j in autojump
#alias zz='fasd_cd -d -i' # cd with interactive selection
# also add these:
alias codef='f -e code'   # quick opening files with code
alias coded='d -e code'   # quick opening directories with code
alias j="z"


# data science
alias csv="xsv"           # xsv is csv by default, the tsv variant is implemented as a function
alias tsvtk="csvtk -t"    # tsv variant of csvtk
alias dm="datamash -H"       # datamash with headers
alias dmc="datamash -H -t,"  # datamash with headers and tsv
alias jqc="jq -C"  # jq with color
alias jqv="jqc . | lessc"  # jq and less with color
alias len="awk '{print length}'"

alias pgrepu="parallel --pipe fgrep" # unordered parallel grep
alias pgrepo="parallel --pipe fgrep" # ordered parallel fgrep

# mlr tsv defaults
alias mlrt="mlr --tsv"
alias mlrtr="mlr --tsv --implicit-csv-header"
alias mlrtrr="mlr --tsv --implicit-csv-header --headerless-csv-output"
alias mlrtp="mlr --tsv --opprint"
# mlr csv defaults
alias mlrc="mlr --csv"
alias mlrcr="mlr --csv --implicit-csv-header"
alias mlrcrr="mlr --csv --implicit-csv-header --headerless-csv-output"
alias mlrcp="mlr --csv --opprint"
# mlr indexed defaults
alias mlrn="mlr --nidx"
alias mlrr="mlr --implicit-csv-header --headerless-csv-output"

# force q to use python2
alias q="python2 /usr/local/bin/q"

# python versions
alias p2="python2"
alias p3="python3"
alias p="python"

alias tab2nl="tr $'\t' '\n'"
alias excel="open -a /Applications/Microsoft\ Excel.app"
alias nb="jupyter notebook"
