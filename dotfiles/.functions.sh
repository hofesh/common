#! bash

# cd + md
cdmd() { md "$1" && cd "$1"; }
# mark spaces with red background color
showspaces() { perl -pe 's/( +)/\033[41m$1\033[00m/g'; }
# get sha1 hash
sha1() { sha1sum | awk '{print toupper($1)}' ;}
# find root with contains logic
_fr() { find / 2> /dev/null -iname "'*$**'" ;}
# find files/dirs using indexed mdfind
spot() { mdfind "kMDItemFSName=='*$(echo $@ | sed -E 's/[ ]+/*/g')*'cd"; }
# spot a file and cd to it's dir
goto() {
  found=`spot $@ | head -1`
  if [[ -d $found ]]; then
    cd "$found"
  elif [[ -f $found ]]; then
    cd "$(dirname "$found")"
  else
    echo "not found: " $@
  fi
}

# remove '\r' chars from a file
function dos2unix() { tr -d '\r' < "$1" | sponge "$1"; }

skip () { awk "NR > $1" ; }
take () { head -$1 ; }


# print all unique rows
uniq_fast() { awk '++dict[$0]==1' $*; }
# print only rows which were unique to start with
uniq_only_fast() { awk '{ ++_[$0] } END { for (k in _) if (_[k]==1) print k }' $*; }
# print only duplicate rows
dup_fast() {	awk '++_[$0]==2' $*; }

## intended to 2 files
# print only rows common (intersecting) between multiple files
comm_fast() { awk 'ARGIND==1 { _[$0]=1; next } !($0 in _) || _[$0]==0 { next } { print; _[$0]=0 }' $*; }
alias inter_fast="comm_fast"
# print the union of all rows between multuple files
union_fast() { awk 'ARGIND==1 { _[$0]=1; print; next } !($0 in _) { print }' $*; }
# print rows found only of the left side file
lhs_only_fast() { awk 'ARGIND==1 { _[$0]=1; next } $0 in _ { _[$0]=0 } END { for (k in _) if (_[k]) print k }' $*; }
# print rows only found on the right side file
rhs_only_fast() { awk 'ARGIND==1 { _[$0]=0; next } !($0 in _) { print; _[$0]=0 }' $*; }
# print the rows which are found in one file but not in the other
diff_fast() { awk 'ARGIND==1 { _[$0]=1; next } !($0 in _) { print } { _[$0]=0 } END { for (k in _) if (_[k]) print k }' $*; }
# print a histogram of the rows (desc sorted count)
freq_fast() { awk '{ ++_[$0] } END { PROCINFO["sorted_in"]="@val_num_desc"; for (k in _) print _[k], k }' $*; }
hist_fast=freq_fast

nunique_fast() { awk '{ ++_[$0] } END { print length(_) }' $*; }

# histogram of one field by another (whitespace version)
histby  () { awk     "{ d[\$$1]+= \$$2 } END { for (k in d) print d[k] \"\t\" k }" | sort -nr; }
# histogram of one field by another (naive csv version)
histbyc () { awk -F, "{ d[\$$1]+= \$$2 } END { for (k in d) print d[k] \"\t\" k }" | sort -nr; }
#export -f histbyc

# histogram of words in text (space seperated)
wordhist  () { awk '{ split($0,words," "); for (w in words) d[words[w]]++ } END { for (w in d) print d[w] "\t" w }' | sort -nr;} && export -f wordhist
# histogram of bigrams (tuples of words) in text (space seperated)
word2hist () { awk '{ split($0,words," "); for (w in words) { if (length(prev)>0) d[prev" "words[w]]++; prev=words[w] } } END { for (w in d) print d[w] "\t" w }' | sort -nr;} && export -f word2hist

# csv to tsv
c2t() { xsv fmt -t $'\t'; }
# tsv to csv
t2c() { xsv input -d $'\t'; }
# space-seperated to tsv
s2t() { tr ' ' '\t'; }
# convert a file in-place (replacing existing file) from csv to tsv
convertcsv2tsv() { cat "$1" | c2t | sponge "$1" ;}

# sort tsv input by n-th field in desc' order
sortt() { sort -t$'\t' -k $1 -nr; }

# use xsv with tab seperator by default for input and output
tsv() {
    local cmd=$1
    shift && command xsv $cmd -d"\t" $@ | c2t
}
# same as tsv but without output reformatting
tsv_() {
    local cmd=$1
    shift && command xsv $cmd -d"\t" $@
}

# awk with tsv input/output
awkt() { awk -F $'\t' "BEGIN { OFS=FS } $1" ; }

# header with tabs instead of commas
# $ `headert -a a,b,c`
# a   b   c 
headert() { header $1 "$(echo "${@:2}" | tr ',' '\t')" ; }

zip_folder() { zip -r "$1.zip" "$1"; }

tar_folder() { tar cvf "$1.tar" "$1"; }

git_expire_and_gc() { git reflog expire --expire-unreachable=now --all && git gc --prune=now; }
git_delete_from_history() {
  git filter-branch --force --index-filter "git rm --cached --ignore-unmatch $1" --prune-empty --tag-name-filter cat -- --all  
}