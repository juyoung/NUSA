BEGIN { FS="\t" } { nl++ } { avg[nl]=$1 } { ontime[nl]=$3 } { late[nl]=$4 } { sent[nl]=$5 } END {
	if(BW == "1000")
		printf "0 %s %f %d %d %d %f\n", BW, avg[IDX], ontime[IDX], late[IDX], sent[IDX], late[IDX]/sent[IDX]*100
	else if(BW == "500")
		printf "1 %s %f %d %d %d %f\n", BW, avg[IDX], ontime[IDX], late[IDX], sent[IDX], late[IDX]/sent[IDX]*100
	else
		printf "2 %s %f %d %d %d %f\n", BW, avg[IDX], ontime[IDX], late[IDX], sent[IDX], late[IDX]/sent[IDX]*100
}
