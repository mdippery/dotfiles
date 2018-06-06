unalias -m '*'

fpath=($DOTZSH/functions $fpath)
for f in $(ls $DOTZSH/functions); do
  autoload $f
done
