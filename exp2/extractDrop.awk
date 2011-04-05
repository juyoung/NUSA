BEGIN { FS="\t" } { nl++ } { sent[nl]=$1 } { drop[nl]=$2 } { recv[nl]=$3 } END {
	printf "%s %f\n", Qsize, drop[IDX]/sent[IDX]*100
}
