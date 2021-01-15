# run this in whatever folder contains the files with spaces in name
for f in *; do mv "$f" `echo $f | tr ' ' '_'`; done
