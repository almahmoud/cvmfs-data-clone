#!/bin/bash
directory=${1:-testdir}
sizelimit=${2:-1000} # in KB
outdir=${3:-separated}
sizesofar=0
dircount=1
touch "$outdir/sub_$dircount.txt"
find "$directory" -type d -exec du -a --block-size=1K {} + | while read -r size file
do
  if ((sizesofar + size > sizelimit))
  then
    echo "Done with chunk $dircount with size $sizesofar KB"
    echo "####### SIZE: $sizesofar KB" >> "$outdir/sub_$dircount.txt"
    (( dircount++ ))
    sizesofar=0
    touch "$outdir/sub_$dircount.txt"
  fi
  (( sizesofar += size ))
  echo "$file" >> "$outdir/sub_$dircount.txt"
done