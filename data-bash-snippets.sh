#! bash

# links
https://github.com/dbohdan/structured-text-tools

============ POSIX commands - good for tasks with no external dependencies =========
https://github.com/learnbyexample/Command-line-text-processing
https://github.com/learnbyexample/Linux_command_line/blob/master/Text_Processing.md

# cat - concat files vertically
cat file # Print the contents of a file to the standard output:
cat file1 file2 > target_file # Concatenate several files into the target file:
cat file1 file2 >> target_file # Append several files into the target file:
cat -n file # Number all output lines:

# paste - merge lines of files
paste -s file # Join all the lines into a single line, using TAB as delimiter:
paste -s -d delimiter file # Join all the lines into a single line, using the specified delimiter:
paste file1 file2 # Merge two files side by side, each in its column, using TAB as delimiter:
paste -d delimiter file1 file2 # Merge two files side by side, each in its column, using the specified delimiter:
paste -d '\n' file1 file2 # Merge two files, with lines added alternatively:
seq 100 | shuf | paste - - - -  # generate data table

# tac - read in reverse
tac a.txt
seq 10 | tac

# seq
seq 10 # Sequence from 1 to 10:
seq 5 3 20 # Every 3rd number from 5 to 20:
seq -s " " 5 3 20 # Separate the output with a space instead of a newline:
seq 100 | shuf | paste - - - -  # generate data

# sort
sort # Sort a file in ascending order:
sort -r # Sort a file in descending order:
sort -n # Sort a file using numeric rather than alphabetic order:
sort -t: -k 3n /etc/passwd # Sort the passwd file by the 3rd field, numerically:
sort -u # Sort a file preserving only unique lines:

# uniq
uniq # Display each line once:
uniq -u # Display only unique lines:
uniq -d # Display only duplicate lines:
uniq -c # Display number of occurrences of each line along with that line:
sort | uniq -c | sort -nr # Display number of occurrences of each line, sorted by the most frequent:

# cut - field extraction
cut -c 1-16 # Cut out the first sixteen characters of each line of STDIN:
cut -c3- # Cut out everything from the 3rd character to the end of each line:
cut -d':' -f5 # Cut out the fifth field of each line, using a colon as a field delimiter (default delimiter is tab):
cut -d';' -f2,10 # Cut out the 2nd and 10th fields of each line, using a semicolon as a delimiter:
cut -d' ' -f3-7 # Cut out the fields 3 through 7 of each line, using a space as a delimiter:

# column
printf "header1 header2\nbar foo\n" | column -c 30 # Format output for a 30 characters wide display:
printf "header1,header2\nbar,foo\n" | column -s, # Specify column delimiter character for the -t option (i.e. "," for csv); default is whitespace:
printf "header1 header2\nbar foo\n" | column -t # Split columns automatically and auto-align in a tabular format:
printf "header1\nbar\nfoobar\n" | column -c 30 -x # Fill columns before filling rows:
cat /etc/passwd | column -t -s:

# rev - reverse each line
echo "123456789" | rev

# tr - char level translations
tr 'a' 'b' # Replace all occurrences of a character in a file, and print the result
tr 'abcd' 'jkmn' # Map each character of the first set to the corresponding character of the second set
tr -d 'asdf' # Delete all occurrences of the specified set of characters from the input
tr -s '\n' # Compress a series of identical characters to a single character
tr "[:lower:]" "[:upper:]"  # Translate the contents of the file to upper-case and print result
tr -cd "[:print:]" # Strip out non-printable characters from the file and print result

# sed - regex replace
sed 's/find/replace/' # Replace the first occurrence of a string in a file, and print the result
sed -E 's/regex/replace/g' # Replace all occurrences of an extended regular expression in a file
sed -i '' 's/find/replace/g' # Replace all occurrences of a string in a file, overwriting the file (i.e. in-place)
sed '/line_pattern/s/find/replace/' # Replace only on lines matching the line pattern
sed -e 's/find/replace/' -e 's/find/replace/' # Apply multiple find-replace expressions to a file
sed 's#find#replace#' # Replace separator / by any other character not used in the find or replace patterns, e.g., #

# grep
grep search_string path/to/file # Search for an exact string:
grep -i search_string path/to/file # Search in case-insensitive mode:
grep -rI search_string . # Search recursively (ignoring non-text files) in current directory for an exact string:
grep -E ^regex$ path/to/file # Use extended regular expressions (supporting `?`, `+`, `{}`, `()` and `|`):
egrep ^regex$ # same as grep -E
grep -F [str] # fixed string search, without using regex
fgrep [str] # same as grep -F
grep -C|B|A 3 search_string path/to/file # Print 3 lines of [C]ontext around, [B]efore, or [A]fter each match:
grep -c search_string path/to/file # Print the count of matches instead of the matching text:
grep -n search_string path/to/file # Print line number for each match:
grep -l search_string path/to/file # Print file names with matches:
grep -v search_string # Invert match for excluding specific strings:

# head
head -n 10 # first 10 lines
hean -c 10 # first 10 chars

# tail
tail -n num file # Show last 'num' lines in file:
tail -n +num file # Show all file since line 'num':
tail -c num file # Show last 'num' bytes in file:
tail -f file # Keep reading file until `Ctrl + C`:

# less
less -S # show color coded input
grep --color | less -S # grep with color in less
(/text) # forward search, n-next, N-prev
(?text) # backward seasrch, n-next, N-prev

# shuf - shuffle data
seq 100 | shuf | paste - - - -  # generate data

# nl
seq 100 | sample -r 0.1 | nl # enmurate lines

# iteration with piping
cat lines.txt | while read ln; do prco1 $ln | proc2 | proc3 > out.txt

# xargs
arguments_source | xargs command # Main usage pattern:
find . -name '*.backup' | xargs rm -v # Delete all files with a `.backup` extension:
arguments_source | tr '\n' '\0' | xargs -0 command # Convert newlines in the input into NUL (`\0`) characters, and split on those only (useful if the input to xargs contains spaces):
arguments_source | xargs -I _ command _ optional_extra_arguments # Execute the command once for each input line, replacing any occurrences of the placeholder (here marked as `_`) with the input line:

# parallel - parallel execution, with proper mixing of results
# syntax basics:
# ::: - everything that follows are arguments to pass in parallel
# {} - the file name
# {.} - the file name without extension
# {/} - the file name without full path
# {//} - the file path without name
parallel gzip ::: file1 file2 file3     # Gzip several files at once, using all cores:
parallel gzip ::: *.log                 # gzip all log files
ls *.txt | parallel -j4 gzip            # Read arguments from stdin, run 4 jobs at once, each gzip will get a single arg from the args input
parallel -a urls.txt wget               # download a list of urls in parallel
cat jobs.txt | parallel                 # run list of jobs in parallel
args | parallel -X command              # Parallel xargs, cram as many args as possible onto one command, each command will get multiple arguments, based on number of cores
cat big_file.txt | parallel --pipe --block 1M command   # Break stdin into ~1M blocks, feed each block to stdin of new command:
parallel -S machine1,machine2 command ::: arg1 arg2     # Run on multiple machines via SSH:
parallel convert {} {.}.png ::: *.jpg   # Convert JPG images to PNG using replacement strings
parallel 'COMMAND with input {} args and output {.}.res args' ::: *.data  # complex commands can use input and output file name substitution
parallel --eta --load 80% --noswap      # extimate ETA, try to avoid over 80% CPU load, avoid new jobs if memory load causes in/out page swaps
parallel echo ::: 0 1 ::: 0 1           # run on every combination of inputs
parallel -k 'sleep {}; echo {}' ::: 5 2 1 4 3  # keep order of output to match that of input
parallel --dry-run 'sleep {}; echo {}' ::: 5 2 1 4 3  # show which command will be executed
seq 10 | parallel -n0 echo "Hello, World"      # repeat the same command without using the arguments
seq 10 | parallel -n0 "curl --header 'Connection: keep-alive' http://localhost:3000 | grep -o xyz | wc -l" # repeat command, complex command
seq 10 | parallel -n2 echo "Hello, World"      # repeat the command with 2 arguments each
parallel -a hosts.txt --colsep ' ' ping -c {1} {2}  # pass arguments by index from a delimiter seperated file

# many parallel examples: http://www.rankfocus.com/use-cpu-cores-linux-commands/
cat big_file.txt | parallel --pipe grep 'pattern' # run parallel grep (unordered)
cat big_file.txt | parallel -k --pipe grep 'pattern' # run parallel grep (ordered)



=============================


git clone https://github.com/jeroenjanssens/data-science-at-the-command-line.git
body
header
cols          $ cat iris.csv | cols -C species body tapkee --method pca | header -r x,y,species
Rio
Rio-mds
Rio-pca
Rio-scatter
arff2csv
csv2arff
csv2vw
drake
dseq          $ dseq -2 0 # day before yesterday till today
dumbplot
explain
pbc
sample
scrape        # same as pup
servewd
unpack
weka
weka-cluster


=========== awk ======================
https://github.com/learnbyexample/Command-line-text-processing/blob/master/gnu_awk.md
http://invisible-island.net/mawk/
https://www.freebsd.org/cgi/man.cgi?query=nawk&sektion=1
https://www.gnu.org/software/gawk/manual/gawk.html
# Good for row data, and simple field seperated data
awk 'CONDITION { EXECUTION }' # default condition is true, and default execution is print
awk '/start_pattern/,/stop_pattern/' # Display a block of text with AWK from start match to end match
awk '0,10 { print }' # print lines 0-10000
awk '/.*/ { print }' # print lines matching regex 
awk '10,/.*/ { print }' # print lines from 10 to first regex match
awk '{ print len($0) }' # print all lines
awk '{ print $1 }' # print first field of line (whitespace seperated fields)
awk 'len($0) > 100 { print $0 }' # print all lines with len greater than 100 (works?)
awk -F, '{ print NF }' # count number of fields in row
awk '{ print length($0),$0; }' | sort -nr # print lines in file with their line length
awk -F '":"' '{$0=$2}1' # split based on string delimiter (the delimiter is '":"' and we pick the 2nd field using $2)


============ q ============
# https://github.com/harelba/q
# space seperated by default
q -t -T # -t input tab seperator, -T output tab seperator
q -d, -D, # -d, input ',' seperator, -D, output ',' seperator
q "select c1,c2 from -" # print first 2 columns by index
q -H "select A,B from -" # select columns by name
ls -ln | q -T 'select * from - where c5 < 100' # all files less that 100 bytes


============ sqawk ============
https://github.com/dbohdan/sqawk
sqawk 'select distinct a7 from a order by a7' FS=: /etc/passwd # List all login shells used on the system.


============ pup ============
# for HTML data
curl -s http://example.com/ | pup --color
curl -s http://example.com/ | pup 'json{}' | jq
curl -s http://example.com/ | pup 'p text{}'
curl -s http://example.com/ | pup 'p > a attr{href}'


============ jq ============
http://stedolan.github.io/jq/
# for JSON data
# Referer extraction
jq '.req.headers[]? | select(.name=="Referer") | .value'
# request is from inside an iframe and not from top frame
jq 'select(.req.parent_frame_id>=1)'
# fast URL matching with contains verification
grep -F "TARGET" | jq 'select(.req.url | contains("TARGET"))'
# fast URL matching with regex verification
grep -F "TARGET" | jq -c 'select(.req.url | test(\"https?://google[.]com\"))'
# multi field results
jq -c '[.req.type, .req.url]'
# multi field with complex fields
jq -c '[.req.impr_id, (.req.headers[]? | select(.name==" Referer") | .value)]'
# filter with external arg
jq -c --arg u 28a20dc0-529f-3b5b-92f6-c47cf61da55a 'select(.uuid==$u)' articles.jsons | less
# jq select with multiple input matches
cat all.tsv | cut -f 3 | xargs -I___ jq -c --arg u ___ 'select(.uuid==$u)' articles.jsons | less
# jq join on 2 files with json rows by a common key field
# https://stackoverflow.com/questions/39830426/join-two-json-files-based-on-common-key-with-jq-utility-or-alternative-way-from



============ miller ============
# Good for heavy lifting with tablur data (and any key-value data)
cd ~/git/miller/doc

mlr --icsv --opprint cat example.csv
cat example.csv | mlrcp sort -f color
cat example.csv | mlrcp cut -f color,shape
cat example.csv | mlrcp filter '$color == "red" && $flag == 1'
cat example.csv | mlrcp put '$ratio = $quantity / $rate; $color_shape = $color . "_" . $shape'
cat example.csv | mlrc --ojson put '$ratio = $quantity/$rate; $shape = toupper($shape)' | jq .
cat example.csv | mlrcp sort -f shape -nr index
cat example.csv | mlrcp sort -f shape -nr index then head -n 1 -g shape
cat example.csv | mlrcp stats1 -a count,min,mean,max -f quantity -g shape
cat example.csv | mlrc put -q 'tee > $shape.".csv", $*'

mlrc -I cut -x -f unwanted_column_name *.csv

cat log.txt
grep op=cache log.txt | mlr --d2p stats1 -a mean -f hit -g type then sort -f type
cat log.txt | mlr --d2p filter 'is_present($batch_size)' then step -a delta -f time,num_filtered then sec2gmt time

cat /etc/group
grep -v '^#' /etc/group | mlr --ifs : --nidx --opprint label group,pass,gid,member then sort -f group

man mlr

============ tapkee ============
# A flexible and efficient С++ template library for dimension reduction http://tapkee.lisitsyn.me
https://github.com/lisitsyn/tapkee


============ bigmler ============
# BigMLer - A command-line tool for BigML's API
https://github.com/bigmlcom/bigmler