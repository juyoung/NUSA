######################################################################
#echo "Packet results of Video traffic (CBR)"
cat out.tr | grep " 0 0.0 9.0 " > traffic1.txt

# sent
cat traffic1.txt | grep " 0 6 cbr " | grep ^+ > sent_t1.packets
awk -f count.awk sent_t1.packets >> drop.packets

# dropped
cat traffic1.txt | grep " 7 8 cbr " | grep ^d > drop_t1.packets
awk -f count.awk drop_t1.packets >> drop.packets

# received
cat traffic1.txt | grep " 8 9 cbr " | grep ^r > recv_t1.packets
awk -f count.awk recv_t1.packets >> drop.packets

rm traffic1.txt
rm sent_t1.packets
rm drop_t1.packets
rm recv_t1.packets

#echo " "
######################################################################
#echo "Packet results of VoIP1 traffic (Pareto)"
cat out.tr | grep " 1 1.0 10.0 " > traffic2.txt

cat traffic2.txt | grep " 1 6 pareto " | grep ^+ > sent_t2.packets
awk -f count.awk sent_t2.packets >> drop.packets

cat traffic2.txt | grep " 7 8 pareto " | grep ^d > drop_t2.packets
awk -f count.awk drop_t2.packets >> drop.packets

cat traffic2.txt | grep " 8 10 pareto " | grep ^r > recv_t2.packets
awk -f count.awk recv_t2.packets >> drop.packets

rm traffic2.txt
rm sent_t2.packets
rm drop_t2.packets
rm recv_t2.packets

#echo " "
######################################################################
#echo "Packet results of VoIP2 traffic (Pareto)"
cat out.tr | grep " 2 2.0 11.0 " > traffic3.txt

cat traffic3.txt | grep " 2 6 pareto " | grep ^+ > sent_t3.packets
awk -f count.awk sent_t3.packets >> drop.packets

cat traffic3.txt | grep " 7 8 pareto " | grep ^d > drop_t3.packets
awk -f count.awk drop_t3.packets >> drop.packets

cat traffic3.txt | grep " 8 11 pareto " | grep ^r > recv_t3.packets
awk -f count.awk recv_t3.packets >> drop.packets

rm traffic3.txt
rm sent_t3.packets
rm drop_t3.packets
rm recv_t3.packets

#echo " "
######################################################################
#echo "Packet results of VoIP3 traffic (Pareto)"
cat out.tr | grep " 3 3.0 12.0 " > traffic4.txt

cat traffic4.txt | grep " 3 6 pareto " | grep ^+ > sent_t4.packets
awk -f count.awk sent_t4.packets >> drop.packets

cat traffic4.txt | grep " 7 8 pareto " | grep ^d > drop_t4.packets
awk -f count.awk drop_t4.packets >> drop.packets

cat traffic4.txt | grep " 8 12 pareto " | grep ^r > recv_t4.packets
awk -f count.awk recv_t4.packets >> drop.packets

rm traffic4.txt
rm sent_t4.packets
rm drop_t4.packets
rm recv_t4.packets

#echo " "
######################################################################
#echo "Packet results of Data1 traffic (Exp)"
cat out.tr | grep " 4 4.0 13.0 " > traffic5.txt

cat traffic5.txt | grep " 4 6 exp " | grep ^+ > sent_t5.packets
awk -f count.awk sent_t5.packets >> drop.packets

cat traffic5.txt | grep " 7 8 exp " | grep ^d > drop_t5.packets
awk -f count.awk drop_t5.packets >> drop.packets

cat traffic5.txt | grep " 8 13 exp " | grep ^r > recv_t5.packets
awk -f count.awk recv_t5.packets >> drop.packets

rm traffic5.txt
rm sent_t5.packets
rm drop_t5.packets
rm recv_t5.packets

#echo " "
######################################################################
#echo "Packet results of Data2 traffic (Exp)"
cat out.tr | grep " 5 5.0 14.0 " > traffic6.txt

cat traffic6.txt | grep " 5 6 exp " | grep ^+ > sent_t6.packets
awk -f count.awk sent_t6.packets >> drop.packets

cat traffic6.txt | grep " 7 8 exp " | grep ^d > drop_t6.packets
awk -f count.awk drop_t6.packets >> drop.packets

cat traffic6.txt | grep " 8 14 exp " | grep ^r > recv_t6.packets
awk -f count.awk recv_t6.packets >> drop.packets

rm traffic6.txt
rm sent_t6.packets
rm drop_t6.packets
rm recv_t6.packets

#echo " "
######################################################################
echo "Counting drop packets DONE"
