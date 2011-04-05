BEGIN { FS = " " } { nl++ } {printf "%-8d%-20f%-20f%-20f\n", nl, $2, $3, $4 } END {}
