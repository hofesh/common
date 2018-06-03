#! bash

============= history =============
!$ # last argument of the previous command
!* # all arguments of the previous command
!! # execute last command
!10 # execute the 10th last command
!!:p # print without executing
!:- # Insert the last command without the last argument (bash)
^foo^bar # Runs previous command but replacing
ESC+. or Alt+. # Place the argument of the most recent command on the shell
ctrl+u # stash currently typed command
ctrl+y # un-stash command
history | awk '{a[$2]++} END {for(i in a){print a[i] " " i}}' | sort -rn | head # List of commands you use most often


============= word modifiers =============
:p # print history command without execution
:h # dir/path name
:t # filename
:r # remove extension
:e # keep only the extension


============= editing =============
Ctrl+x+e # open editor on whatever was typed so far


============= shell =============
reset # Salvage a borked terminal
ctrl+l # clear screen
\aliased # escape aliased command to call the original


============= schedualing =============
echo "ls -l" | at midnight # Execute a command at a given time
watch -n 2 df -h # watch free space deplete every 2 seconds
watch -d ls -l   # watch a directory for changes


============= zipping =============
tar xfvz file   # unzip tar ball
tar cfvz file folder   # zip tar ball
gzip file       # inplace compress
gzip -d file    # inplace decompress
gzip --fast     # for fast processing
gzcat file      # cat a zipped file


============= web requests =============
curl http://example.com > res.html # simple get
wget URL -O path/to/file
wget --random-wait -r -p -e robots=off -U mozilla http://www.google.com # Download an entire website
# -p parameter tells wget to include all files, including images.
# -e robots=off you don't want wget to obey by the robots.txt file
# -U mozilla as your browsers identity.
# --random-wait to let wget chose a random number of seconds to wait, avoid get into black list.
# Other Useful wget Parameters:
# --limit-rate=20k limits the rate at which it downloads files.
# -b continues wget after logging out.
# -o $HOME/wget_log.txt logs the output


============= profiling =============
time COMMAND # measure execution time (simple)
start_time=`date +%s`; ____command____ && echo run time is $(expr `date +%s` - $start_time)s  # measure execution time (complex)
sample pid # provide a call tree based on sampling


============= processes =============
htop # task manager
ps aux | sort -nk +4 | tail | cut -c -200 # Display the top ten running processes - sorted by memory usage
pstree # process tree
pkill -f python # kill all python processes
ps -u USER # show all processes of user
killall -u USER bunzip2 # kill process of user


=========== background processes ============
ping -i 5 google.com
ctrl-z # move the current process to the background in a suspended state.
jobs -l # list the current background processes for the current tty session.
bg # tell the most recent background process to continue running in the background
fg # bring the most recent background process back to the foreground
disown -h # disown the most recent background job. This will remove it from your current tty session. It will not be able to be brought back to the foreground. You will have to control it either with kill or something else.
disown -a && exit # Close shell keeping all subprocess running
kill %1 # kill job #1 on the jobs list
kill -9 $(jobs -p) # kill all jobs (if they are stopped)
nohup ./go.py > go.log 2>&1 & # async run


============= diff =============
diff <(sort file1) <(sort file2) # diff two unsorted files without creating temporary files


============= globbing =============
rm !(*.foo|*.bar|*.baz) # remove all but specific files


============= key binding =============
bind '"\C-o":"ranger-cd\C-m"' # bind Ctrl+o to "ranger-cd<ENTER>"
bind -r "\C-o" # unbind Ctrl+o


============= script control =============
return 0 # exit from script
exit 0 # exit bash


============= clipboard =============
echo asdf | pbcopy # mac
pbpaste # mac
echo asdf > /dev/clipboard # Git-Bash windows


============= performance tweaks =============
export LC_ALL=C # make grep faster


============= text search =============
ag target # regex search
ag -Q target # plain text search

============= HD sapce =============
du -h . | sort -rh | less # check what takes up space
df -h # check amount of free space

============= dir listing =============
ls -ltr # ls by reverse modified date
ls -lS  # ls by size

============= files =============
ls -1 *.JPG | head -500 | xargs -i mv {} folder # move max N files to folder

============= special chars =============
# for handling chars like \n \r new-line space tab
seq 100 | sample -r 0.1 | nl | rev | showspaces # show hidden spaces
mlr lecat # show CR / LF
mlr termcvt # fix CR / LF
dos2unix file # remove '\r' from a single file (custom func)
cat -A file # show all special chars
grep -rl --binary-files=without-match -E '\x0d' . # find all files with \r in them
grep -rl --binary-files=without-match -E '\x0d' . | env_parallel dos2unix # remove '\r' from all files containing it

============= reveal command =============
type showspaces # function
type ll         # alias
type cat        # binary
type cd         # bash builtin function
which CMD       # find path of command
which -a CMD    # find all instances of CMD in PATH

============= log file progress =============
tail -f file # use tail -F to also keep track if the file get's closed/reopen/removed
less +F file



============ find ===============
find . -name "*.tif"        # find by globbing
find . -size 0 -delete      # remove empty files
find . -size -160k -delete  # remove files smaller than 160k

============= rsync ===========
rsync opt FROM TO
--ignore-existing
--update
-h: human readable numbers
-v: verbose
-r: recurse into directories
-P: --partial (keep partially transferred files) +
    --progress (show progress during transfer)
-t: preserve modification times

rsync --ignore-existing -hvPt SERVER:FOLDER/* LOCAL_FOLDER

# parallel rsync: https://unix.stackexchange.com/questions/189878/parallelise-rsync-using-gnu-parallel
                                                  rsync -vzmh --stats --safe-links --ignore-existing --dry-run SERVER:FOLDER    LOCAL_FOLDER > /tmp/transfer.log
cat /tmp/transfer.log | parallel --will-cite -j 5 rsync -vzmh --stats --safe-links --ignore-existing           SERVER:FOLDER/{} LOCAL_FOLDER > /tmp/result.log