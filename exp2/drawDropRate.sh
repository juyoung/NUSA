# Draw a graph that shows Drop rate for each bandwidth (1Mb, 500Kb, 100Kb) with varing queue sizes

BW=( '1000' '500' '100' )

for ((i=1; i<=6; i++))
do
	awk -v Qsize="20000" -v IDX=$i -f extractDrop.awk ../00.Inf_Queue/01_1Mb/drop.packet >> $i.${BW[0]}
	awk -v Qsize="1000" -v IDX=$i -f extractDrop.awk ../01.1000_Queue/01_1Mb/drop.packet >> $i.${BW[0]}
	awk -v Qsize="500" -v IDX=$i -f extractDrop.awk ../02.500_Queue/01_1Mb/drop.packet >> $i.${BW[0]}
	awk -v Qsize="100" -v IDX=$i -f extractDrop.awk ../03.100_Queue/01_1Mb/drop.packet >> $i.${BW[0]}
	awk -v Qsize="50" -v IDX=$i -f extractDrop.awk ../04.50_Queue/01_1Mb/drop.packet >> $i.${BW[0]}
	awk -v Qsize="20" -v IDX=$i -f extractDrop.awk ../05.20_Queue/01_1Mb/drop.packet >> $i.${BW[0]}
	awk -v Qsize="10" -v IDX=$i -f extractDrop.awk ../06.10_Queue/01_1Mb/drop.packet >> $i.${BW[0]}

	awk -v Qsize="20000" -v IDX=$i -f extractDrop.awk ../00.Inf_Queue/02_500Kb/drop.packet >> $i.${BW[1]}
	awk -v Qsize="1000" -v IDX=$i -f extractDrop.awk ../01.1000_Queue/02_500Kb/drop.packet >> $i.${BW[1]}
        awk -v Qsize="500" -v IDX=$i -f extractDrop.awk ../02.500_Queue/02_500Kb/drop.packet >> $i.${BW[1]}
        awk -v Qsize="100" -v IDX=$i -f extractDrop.awk ../03.100_Queue/02_500Kb/drop.packet >> $i.${BW[1]}
        awk -v Qsize="50" -v IDX=$i -f extractDrop.awk ../04.50_Queue/02_500Kb/drop.packet >> $i.${BW[1]}
        awk -v Qsize="20" -v IDX=$i -f extractDrop.awk ../05.20_Queue/02_500Kb/drop.packet >> $i.${BW[1]}
        awk -v Qsize="10" -v IDX=$i -f extractDrop.awk ../06.10_Queue/02_500Kb/drop.packet >> $i.${BW[1]}

	awk -v Qsize="20000" -v IDX=$i -f extractDrop.awk ../00.Inf_Queue/03_100Kb/drop.packet >> $i.${BW[2]}
        awk -v Qsize="1000" -v IDX=$i -f extractDrop.awk ../01.1000_Queue/03_100Kb/drop.packet >> $i.${BW[2]}
        awk -v Qsize="500" -v IDX=$i -f extractDrop.awk ../02.500_Queue/03_100Kb/drop.packet >> $i.${BW[2]}
        awk -v Qsize="100" -v IDX=$i -f extractDrop.awk ../03.100_Queue/03_100Kb/drop.packet >> $i.${BW[2]}
        awk -v Qsize="50" -v IDX=$i -f extractDrop.awk ../04.50_Queue/03_100Kb/drop.packet >> $i.${BW[2]}
        awk -v Qsize="20" -v IDX=$i -f extractDrop.awk ../05.20_Queue/03_100Kb/drop.packet >> $i.${BW[2]}
        awk -v Qsize="10" -v IDX=$i -f extractDrop.awk ../06.10_Queue/03_100Kb/drop.packet >> $i.${BW[2]}

done

gnuplot graphDropRate1.dem
gnuplot graphDropRate2.dem
gnuplot graphDropRate3.dem


rm *.1000 *.500 *.100

#for ((i=1; i<=6; i++))
#do
#	rm $i.${BW[0]}
#	rm $i.${BW[1]}
#	rm $i.${BW[2]}
#done

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

