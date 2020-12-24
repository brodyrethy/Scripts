# run this in whaterver folder contains the files with spaces
for f in *; do mv "$f" `echo $f | tr ' ' '_'`; done
