# re-orgranize table of dropped packets

awk -f dropPackets.awk drop.packets > drop.packet

rm drop.packets
