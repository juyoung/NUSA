#!/bin/sh
#
# This script generates pdf files from eps files under each directory
# HowToUse: just run ./topdf.sh
# Then, you will get pdf files in each directory
#
# Once you get all pdf files, as a next step you have to merge them altogether.
# To this end, use the following command
# gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=your_new_file.pdf *.pdf
# The command will generate your_new_file.pdf in current directory.
#

mkdir graphs
mv *.eps ./graphs

FILE_LIST=`find . -name "*.eps"`
echo files found: $FILE_LIST

for f in $FILE_LIST
do
    dirbase=`dirname $f`
    base=`basename $f | cut -d '.' -f 1`
    epstopdf --outfile="${dirbase}_$base.pdf" $f 
    echo "${dirbase}_$base.pdf generated"
done

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=graphs.pdf *.pdf

sleep 2
mv graphs.pdf ./graphs
rm *.pdf

echo Done
