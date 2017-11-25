# Mac Apps
CopyLess
    Alt+Command+C = Open Menu

Open / Search
    Alt+Space = Alfred
    Alt+Space+"'" = Alfred file search
    Ctrl+Space = Spotlight
    Ctrl+Alt+Space = finder file search

finder
    Cmd+Shift+G = jump to path

app switching
    Alt+Tab = HyperSwitch
    Alt+` = HyperSwitch windows in app
    Command+Tab = switch app
    Command+` = switch window in app

iTerm
    Cmd+Shift+H - all text history
    Cmd+D - new split
    Cmd+Shift+d - new alt split


# bash
ctrl-a - move the cursor to the beginning of the current line
ctrl-e - move the cursor to the end of the current line
alt-b / ctrl-left - move the cursor backwards one word
alt-f / ctrl-right - move the cursor forward one word
ctrl-k - delete from cursor to the end of the line
ctrl-u - delete from cursor to the beginning of the line
alt-d - delete the word in front of the cursor
ctrl-w - delete the word behind of the cursor


# fzf
Ctrl+t: search and paste inline
Ctrl+r: search history and paste inline
Alt+c: search for dir and cd to it


# tmux
https://gist.github.com/andreyvit/2921703
https://gist.github.com/MohamedAlaa/2961058
C=Ctrl, M=Alt
prefix: C+a

bash: tmux a    attach

Panes
|           h split
_           v split
C+Arrows    resize x5
M+Arrows    resize x1
!           move pane to a new window
x           kill pane
[un-prefixed]
M+Arrows - change split


Sessions
:new       new session
s          list sessions
$          name session
(          previous session
)          next session
L          ‘last’ (previously used) session
s          choose a session from a list

Windows
c          create a new window
0 .. 9     switch to window 1, ..., 9, 0
p          previous window
n          next window
l          ‘last’ (previously used) window
w          choose window from a list
,          rename the current window
f          find window
&          kill the current window

Layouts
M-1        switch to even-horizontal layout
M-2        switch to even-vertical layout
M-3        switch to main-horizontal layout
M-4        switch to main-vertical layout
M-5        switch to tiled layout
space      switch to the next layout

Other
r           reload config
?           list shortcuts
t           big clock

kill
tmux kill-server        cleanly and gracefully kill all tmux open sessions (and server)
tmux kill-session -a    If you are inside a tmux session you would like to keep, to close all other sessions.
bash: killall tmux      just in case
bash: pkill -f tmux     same?


# ranger
http://ranger.nongnu.org/cheatsheet.png
Shift+S - Enter new shell in curr path
Tab - next tab
Alt+Number - choose/create tab
q - close tab (last tab closed will close ranger)
Q - clsoe ranger
space - select files
yy - copy files
dd - cut files
pp - paste files
ya - add files to be copied to a list
da - add files to be cut to a list
Enter - open file with default program
r - choose how to open file
t - tag file with * (persistant)
"+char - tag file with any char (persistant)
:flat -1, 0, 1, 2 ..  - flatten folders (-1 infinite, 0 none)
o - sort files list
zf - filter files
zh - show hidden files
H - history back
L - history forward