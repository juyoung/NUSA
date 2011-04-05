BEGIN { FS = " " } { nl++ } END {
		if (nl > 0)
			print nl
		else
			print "0"
	}
