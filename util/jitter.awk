BEGIN { FS = " " } { nl++ } { src[nl] = $2 } { dst[nl] = $3 } END {
	diff1 = 0
	diff2 = 0

	for (i = 1; i <= (nl-1); i++) {
		diff1  = src[i+1] - src[i]
		diff2  = dst[i+1] - dst[i]
		jitter = diff2 - diff1
		printf "%6d%10f%10f%10f\n", i, diff2, diff1, jitter
	}
}
