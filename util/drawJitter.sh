# draws jitter graphs

BW=""
Qsize=""
 
while read line
do
BW=$line
done < 'BW.txt'
 
while read line
do
Qsize=$line
done < 'Qsize.txt'

rm BW.txt
rm Qsize.txt


XLABEL='Packet Sequence Number'
YLABEL='Jitter in second'
OUTPUT=( 'videoJitter.eps' 'voip1Jitter.eps' 'voip2Jitter.eps' 'voip3Jitter.eps' 'data1Jitter.eps' 'data2Jitter.eps' )
FILE=( 'video.jitter' 'voip1.jitter' 'voip2.jitter' 'voip3.jitter' 'data1.jitter' 'data2.jitter' )
TYPE=( 'Vidoe' 'Voip1' 'Voip2' 'Voip3' 'Data1' 'Data2' )
EXPR="Jitter"
COND="with $BW BW and $Qsize of queue size"


for ((i=0;i<6;i++)); do	
	TI="${TYPE[$i]} $EXPR $COND"
	awk -v XL="$XLABEL" -v YL="$YLABEL" -v OUT="${OUTPUT[$i]}" -v FL="${FILE[$i]}" -v TI="$TI" -f graphJitter.awk default.dem > graph.dem
	gnuplot graph.dem
done 

rm graph.dem

echo 'DONE'
