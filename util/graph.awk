BEGIN { FS = ":" } { nl++ } { val[nl] = $2 } END {
	printf "%s\n", val[1]
	printf "%s %c%s%c\n", val[2], 34, XL, 34
	printf "%s %c%s%c\n", val[3], 34, YL, 34
	printf "%s\n", "set yrange [0:0.2]"
	printf "%s\n", val[4]
	printf "%s\n", val[5]
	printf "%s\n", val[6]
	printf "%s %c%s%c\n", val[7], 34, OUT, 34
	printf "%s %c%s%c %s %c%s%c\n", val[8], 34, FL, 34, "using 1:4 t", 34, TI, 34
	printf "%s\n", val[9]
	printf "%s\n", val[10]
	printf "%s\n", val[11]
}
