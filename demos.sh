cd demos

cat iris.csv | csv stats | csv table
cat iris.csv | mlrc histogram -f sepal_width --nbins 10 --auto | skip 1 | mlrcr bar -f 3
cat iris.csv | csvtk plot hist -f sepal_width > plot.png & open plot.png
cat iris.csv | body shuf | head -20 | csv table
cat iris.csv | c2t | t2c | less
cat iris.csv | mlr --c2j cat
cat iris.csv | mlr --c2m cat
cat iris.csv | head > iris.10.csv; mlrc cat iris.csv iris.10.csv | less
cat iris.csv | body sample -r 0.1 | csv table
cat iris.csv | mlrc filter 'urand() < 0.1 && $species=="setosa"'
cat iris.csv | mlrcp filter '$sepal_length > 5 && $species=="setosa"'
seq 10 | mlrcr bootstrap -n 200 | hist_fast | sort -n -k2 | mlrn bar -f 1
cat iris.csv | mlrcp stats1 -a mean -f petal_length -g species
cat iris.csv | dmc -sg species mean petal_length | csv table
cat medium | mlr --otsv cat | dm crosstab a,b sum x | skip 1 | tsv table

uniq_fast <(seq 10; seq 5 15)
uniq_only_fast <(seq 10; seq 5 15)
dup_fast <(seq 10; seq 5 15)

lhs_only_fast  <(seq 1 10) <(seq 5 15)
rhs_only_fast  <(seq 1 10) <(seq 5 15)
comm_fast  <(seq 1 10) <(seq 5 15)
union_fast  <(seq 1 10) <(seq 5 15)
diff_fast  <(seq 1 10) <(seq 5 15)

# miller
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

# pup
curl -s http://example.com/ | pup --color
curl -s http://example.com/ | pup 'json{}' | jq
curl -s http://example.com/ | pup 'p text{}'
curl -s http://example.com/ | pup 'p > a attr{href}'

# q
ls -ln | q -T 'select * from - where c5 < 100' # all files less that 100 bytes


wget --random-wait -r -p -e robots=off -U mozilla http://www.cnn.com
cat index.html | pup 'a attr{href}' | grep http | parallel wget


curl -sL https://en.wikipedia.org/wiki/Special:Random | pup 'p text{}' | sed 's/[^a-zA-Z ]//g' | wordhist | cut -f2 | head -20
comm_fast <(t1) <(t1)


