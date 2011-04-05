BEGIN { FS = " " } { nl++ } { val[nl] = $4 } { sum = sum + $4 } END {
	avg = sum / nl
	max = val[1]
	min = val[1]
	suc = 0
	fail = 0

	for (i in val) {
		d = val[i] - avg
		sum2 = sum2 + d * d

		if(val[i] <= 0.15)
			suc++
		else
			fail++

		if(val[i] > max)
			max = val[i]

		if(val[i] < min)
			min = val[i]
		
	}
	print avg "\t" sqrt(sum2/nl) "\t" suc "\t" fail "\t" nl "\t" max "\t" min }
