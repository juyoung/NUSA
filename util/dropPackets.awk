BEGIN { FS = " " } { nl++ } { val[nl] = $1 }  END {
	cnt = 1
	
	for (i = 1; i <= nl; i++) {
		
		if (cnt % 3 == 0)
			printf "%d\n",  val[i]
		else
			printf "%d\t",  val[i]

		cnt++
	}
}
