BEGIN { FS="\t" } { nl++ } { avg[nl]=$1 } { ontime[nl]=$3 } { late[nl]=$4 } { sent[nl]=$5 } END {
	printf "%s %f %f\n", Qsize, avg[IDX], late[IDX]/sent[IDX]*100
}
