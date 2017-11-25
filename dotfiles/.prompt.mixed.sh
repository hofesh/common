#! bash

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color';
fi;

prompt_git() {
	local s='';
	local branchName='';

	# Check if the current directory is in a Git repository.
	if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null;

			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				s+='stg.';
			fi;

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				s+='mod.';
			fi;

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+='utr.';
			fi;

			# Check for stashed files.
			if $(git rev-parse --verify refs/stash &>/dev/null); then
				s+='$';
			fi;

		fi;

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo '(unknown)')";

		[ -n "${s}" ] && s=" [${s}]";

		#echo -e "${s}";
        echo -e "${1}${branchName}${2}${s}";
	else
		return;
	fi;
}

jobs_count() {
	cnt=$(jobs | grep -vF Done | wc -l)
    running=$(jobs | grep -F Running | wc -l)
	if [ $cnt -gt 0 ]; then
		#echo -ne " \e[93m${cnt}\e[m"
        echo -ne " ($running/$cnt)"
	fi
}

# based on: https://stackoverflow.com/questions/1862510/how-can-the-last-commands-wall-time-be-put-in-the-bash-prompt/2732282
function timer_now {
    date +%s%N
}

function timer_start {
    timer_start=${timer_start:-$(timer_now)}
}

function timer_stop {
    local delta_us=$((($(timer_now) - $timer_start) / 1000))
    local us=$((delta_us % 1000))
    local ms=$(((delta_us / 1000) % 1000))
    local s=$(((delta_us / 1000000) % 60))
    local m=$(((delta_us / 60000000) % 60))
    local h=$((delta_us / 3600000000))
    # Goal: always show around 3 digits of accuracy
    if ((h > 0)); then timer_show=${h}h${m}m
    elif ((m > 0)); then timer_show=${m}m${s}s
    elif ((s >= 10)); then timer_show=${s}.$((ms / 100))s
    elif ((s > 0)); then timer_show=${s}.$(printf %03d $ms)s
    elif ((ms >= 100)); then timer_show=${ms}ms
    elif ((ms > 0)); then timer_show=${ms}.$((us / 100))ms
    else timer_show=${us}us
    fi
    unset timer_start
}

set_prompt () {
    local Last_Command=$? # Must come first!

    timer_stop
    
    # perform mem/file sync  of history
    history -a # Append the new history lines to the history file
    #history -n # Append the history lines not already read from the history file to the current history list | we don't want this options on to allow ctrl+r to work locally per shell

    if tput setaf 1 &> /dev/null; then
        # Solarized colors, taken from http://git.io/solarized-colors.
        tput sgr0; # reset colors
        bold=$(tput bold);
        reset=$(tput sgr0);
        black=$(tput setaf 0);
        blue=$(tput setaf 33);
        cyan=$(tput setaf 37);
        green=$(tput setaf 64);
        orange=$(tput setaf 166);
        purple=$(tput setaf 125);
        magenta=$purple
        red=$(tput setaf 124);
        violet=$(tput setaf 61);
        white=$(tput setaf 15);
        yellow=$(tput setaf 136);
    else
        # regular colors
        bold='';
        reset="\e[0m";
        black="\e[1;30m";
        blue="\e[1;34m";
        cyan="\e[1;36m";
        green="\e[1;32m";
        orange="\e[1;33m";
        purple="\e[1;35m";
        magenta=$purple
        red="\e[1;31m";
        violet="\e[1;35m";
        white="\e[1;37m";
        yellow="\e[1;33m";
    fi;


    local reset='\[\e[00m\]'
    local FancyX='\342\234\227'
    #local FancyX='!'
    local Checkmark='\342\234\223'
    #local Checkmark='$'

    # regular colors
    # local Black="\[\033[0;30m\]"   
    # local Red="\[\033[0;31m\]"   
    # local Green="\[\033[0;32m\]"   
    # local Yellow="\[\033[0;33m\]"   
    # local Blue="\[\033[0;34m\]"    
    # local Magenta="\[\033[0;35m\]"  
    # local Cyan="\[\033[0;36m\]"   
    # local White="\[\033[0;37m\]"  

    # empahsized (bolded) colors
    local EMK="\[\033[1;30m\]"
    local EMR="\[\033[1;31m\]"
    local EMG="\[\033[1;32m\]"
    local EMY="\[\033[1;33m\]"
    local EMB="\[\033[1;34m\]"
    local EMM="\[\033[1;35m\]"
    local EMC="\[\033[1;36m\]"
    local EMW="\[\033[1;37m\]"

    # background colors
    local BGK="\[\033[40m\]"
    local BGR="\[\033[41m\]"
    local BGG="\[\033[42m\]"
    local BGY="\[\033[43m\]"
    local BGB="\[\033[44m\]"
    local BGM="\[\033[45m\]"
    local BGC="\[\033[46m\]"
    local BGW="\[\033[47m\]"


    # truncate long dir paths    
    local pwdmaxlen=100 # How many characters of the $PWD should be kept
    local trunc_symbol="..." # Indicate that there has been dir truncation
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi

    # identify that we are running a shell within a shell
    local parent=$(ps -o comm= $PPID)
    [[ $parent == login ]] && parent=""
    [[ -n "$RANGER_LEVEL" ]] && parent="ranger" # https://github.com/ranger/ranger/blob/master/examples/bash_subshell_notice.sh

    # files=""
    # if [[ $PREV_PWD != "$PWD" ]]; then
    #     v=$(( $(stty size | cut -d' ' -f2) - 5))
    #     files=$(echo $(ls) | sed 's/ / \| /g')
    #     filesClean=$(echo "$files" | gsed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g")
    #     [ ${#filesClean} -ge $v ] && files=$(echo "$files" | cut -c1-$v)...
    # fi
    # PREV_PWD="$PWD"
    #files=$(echo $(ls) | sed 's/ / \| /g' | cut -c1-$v)

    PS1=""

    # If root, just print the host in red. Otherwise, print the current user
    # and host in green.
    # if [[ $EUID == 0 ]]; then
    #     PS1+="$Red\\u$Green@\\h "
    # else
    #     PS1+="$Green\\u@\\h "
    # fi
    
    [[ -n $parent ]] && PS1+="${cyan}(in $parent) " # parent process
    PS1+="${yellow}($timer_show) \D{%d-%m-%Y} \t" # ellapsed time and current date time
    PS1+="${magenta}\[\`jobs_count\`\]" # background jobs count
    PS1+="${white} in ${green}$NEW_PWD" # path
    PS1+="\$(prompt_git \"\[${white}\] on \[${violet}\]\" \"\[${blue}\]\")"; # Git repository details    
    PS1+="\n"
    # [[ -n $files ]] && PS1+="$Green{$Reset $files $Green}$Reset\n"
    # If last command was successful, print a green check mark. Otherwise, print a red X.
    if [[ $Last_Command == 0 ]]; then
        PS1+="${green}${Checkmark} "
    else
        PS1+="${red}$Last_Command $FancyX "
    fi
    PS1+="$reset" # DONE

    # record long-term bash history
    if [ "$(id -u)" -ne 0 ]; then 
        echo -e "$(date "+%Y-%m-%d.%H:%M:%S")\t$(pwd)\t$(history 1 | sed 's/^ *[0-9]* *//')" >> $historyLogPath/custom-$(date "+%Y-%m").log; 
    fi
}

trap 'timer_start' DEBUG
PROMPT_COMMAND='set_prompt'

