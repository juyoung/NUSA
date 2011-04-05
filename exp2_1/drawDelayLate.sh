# Draw a graph that shows Average Delay for each bandwidth (1Mb, 500Kb, 100Kb) with varing queue sizes
# Queue size 10, 20, 50, 100, 500, 1000, and 2000000000(Inf)

rm *.100 *.500 *.1000

BW=( '1000' '500' '100' )

for ((i=1; i<=6; i++))
do
	awk -v Qsize="20000" -v IDX=$i -f extractEED.awk ../00.Inf_Queue/01_1Mb/results.EED >> $i.${BW[0]}
	awk -v Qsize="1000" -v IDX=$i -f extractEED.awk ../01.1000_Queue/01_1Mb/results.EED >> $i.${BW[0]}
	awk -v Qsize="500" -v IDX=$i -f extractEED.awk ../02.500_Queue/01_1Mb/results.EED >> $i.${BW[0]}
	awk -v Qsize="100" -v IDX=$i -f extractEED.awk ../03.100_Queue/01_1Mb/results.EED >> $i.${BW[0]}
	awk -v Qsize="50" -v IDX=$i -f extractEED.awk ../04.50_Queue/01_1Mb/results.EED >> $i.${BW[0]}
	awk -v Qsize="20" -v IDX=$i -f extractEED.awk ../05.20_Queue/01_1Mb/results.EED >> $i.${BW[0]}
	awk -v Qsize="10" -v IDX=$i -f extractEED.awk ../06.10_Queue/01_1Mb/results.EED >> $i.${BW[0]}

	awk -v Qsize="20000" -v IDX=$i -f extractEED.awk ../00.Inf_Queue/02_500Kb/results.EED >> $i.${BW[1]}
	awk -v Qsize="1000" -v IDX=$i -f extractEED.awk ../01.1000_Queue/02_500Kb/results.EED >> $i.${BW[1]}
        awk -v Qsize="500" -v IDX=$i -f extractEED.awk ../02.500_Queue/02_500Kb/results.EED >> $i.${BW[1]}
        awk -v Qsize="100" -v IDX=$i -f extractEED.awk ../03.100_Queue/02_500Kb/results.EED >> $i.${BW[1]}
        awk -v Qsize="50" -v IDX=$i -f extractEED.awk ../04.50_Queue/02_500Kb/results.EED >> $i.${BW[1]}
        awk -v Qsize="20" -v IDX=$i -f extractEED.awk ../05.20_Queue/02_500Kb/results.EED >> $i.${BW[1]}
        awk -v Qsize="10" -v IDX=$i -f extractEED.awk ../06.10_Queue/02_500Kb/results.EED >> $i.${BW[1]}

	awk -v Qsize="20000" -v IDX=$i -f extractEED.awk ../00.Inf_Queue/03_100Kb/results.EED >> $i.${BW[2]}
        awk -v Qsize="1000" -v IDX=$i -f extractEED.awk ../01.1000_Queue/03_100Kb/results.EED >> $i.${BW[2]}
        awk -v Qsize="500" -v IDX=$i -f extractEED.awk ../02.500_Queue/03_100Kb/results.EED >> $i.${BW[2]}
        awk -v Qsize="100" -v IDX=$i -f extractEED.awk ../03.100_Queue/03_100Kb/results.EED >> $i.${BW[2]}
        awk -v Qsize="50" -v IDX=$i -f extractEED.awk ../04.50_Queue/03_100Kb/results.EED >> $i.${BW[2]}
        awk -v Qsize="20" -v IDX=$i -f extractEED.awk ../05.20_Queue/03_100Kb/results.EED >> $i.${BW[2]}
        awk -v Qsize="10" -v IDX=$i -f extractEED.awk ../06.10_Queue/03_100Kb/results.EED >> $i.${BW[2]}

done

gnuplot graphDelay1.dem
gnuplot graphDelay2.dem
gnuplot graphDelay3.dem
gnuplot graphLate1.dem
gnuplot graphLate2.dem
gnuplot graphLate3.dem


