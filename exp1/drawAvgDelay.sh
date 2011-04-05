# Draw a graph that shows average end-to-end delay for each bandwidth (1Mb, 500Kb, 100Kb) with an infinite queue

#for ((i=1; i<=6; i++))
#do
#	rm $i.traffic
#done

# Extract average delay, # of deadline missing, successful, and sent packets
for ((i=1; i<=6; i++))
do
	awk -v BW="1000" -v IDX=$i -f extractEED.awk ../00.Inf_Queue/01_1Mb/results.EED >> $i.traffic
	awk -v BW="500" -v IDX=$i -f extractEED.awk ../00.Inf_Queue/02_500Kb/results.EED >> $i.traffic
	awk -v BW="100" -v IDX=$i -f extractEED.awk ../00.Inf_Queue/03_100Kb/results.EED >> $i.traffic
done

gnuplot graphAvgEED.dem
gnuplot graphDeadline.dem

for ((i=1; i<=6; i++))
do
	rm $i.traffic
done

#XLABEL='Bandwidth'
#YLABEL='Average End-to-End Delay in second'
#OUTPUT=( 'videoAvgEED.eps' 'voip1AvgEED.eps' 'voip2AvgEED.eps' 'voip3EAvgED.eps' 'data1AvgEED.eps' 'data2AvgEED.eps' )
#TYPE=( 'Vidoe' 'Voip1' 'Voip2' 'Voip3' 'Data1' 'Data2' )
#EXPR="Average End-to-End Delay"
#COND="with $BW BW and $Qsize of queue size"
 
#for ((i=1; i<=6; i++)); do
#	#TI="${TYPE[$i]} $EXPR $COND"
#	TI="${TYPE[$i]} $EXPR"
#        awk -v XL="$XLABEL" -v YL="$YLABEL" -v OUT="${OUTPUT[$i]}" -v FL="$i.traffic" -v TI="$TI" -f graph.awk default.dem > graph.dem
#        gnuplot graph.dem
#done
 
#rm graph.dem

