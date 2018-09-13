#! bash

# show last 10 dirs with "cd --"
test -f ~/acd_func.sh && source ~/acd_func.sh

# facd https://github.com/clvv/fasd
type fasd >/dev/null 2>&1 && eval "$(fasd --init auto)"

# autojump
#[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# like autojump with with bash only code (no python)
#source ~/z.sh

[ -f ~/anaconda3/bin/virtualenvwrapper_lazy.sh ] && source ~/anaconda3/bin/virtualenvwrapper_lazy.sh

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# adds a env_parallel functions that allows to run parallel executions on functions
[ -f /usr/local/bin/env_parallel.bash ] && source /usr/local/bin/env_parallel.bash


