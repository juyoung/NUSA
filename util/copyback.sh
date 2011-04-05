
while read path
do
#echo $line

cp ./*.eps $path
cp ./*.jitter $path
cp ./drop.packet $path
cp ./results.EED $path

done < 'path.txt'

echo "Copy DONE"


