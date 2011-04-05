# draws EED graphs

param=""
BW=""
Qsize=""

while read line
do
param=$line
done < 'param.txt'

#echo $param
echo $param | awk '{ FS=" " } { print $1 }' > BW.txt
echo $param | awk '{ FS=" " } { print $2 }' > Qsize.txt

while read line
do
BW=$line
done < 'BW.txt'

while read line
do
Qsize=$line
done < 'Qsize.txt'

XLABEL='Packet Sequence Number'
YLABEL='End-to-End Delay in second'
OUTPUT=( 'videoEED.eps' 'voip1EED.eps' 'voip2EED.eps' 'voip3EED.eps' 'data1EED.eps' 'data2EED.eps' )
FILE=( 'video.result' 'voip1.result' 'voip2.result' 'voip3.result' 'data1.result' 'data2.result' )
TYPE=( 'Vidoe' 'Voip1' 'Voip2' 'Voip3' 'Data1' 'Data2' )
EXPR="EED"
COND="with $BW BW and $Qsize of queue size"

for ((i=0;i<6;i++)); do	
	TI="${TYPE[$i]} $EXPR $COND"
	awk -v XL="$XLABEL" -v YL="$YLABEL" -v OUT="${OUTPUT[$i]}" -v FL="${FILE[$i]}" -v TI="$TI" -f graph.awk default.dem > graph.dem
	gnuplot graph.dem
done 

rm graph.dem

echo 'DONE'
