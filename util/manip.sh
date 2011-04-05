# replace all 0s at the first column with sequence number in traffic EED files.

awk -f manip.awk video.result > temp.txt
rm video.result
mv temp.txt video.result

awk -f manip.awk voip1.result > temp.txt
rm voip1.result
mv temp.txt voip1.result

awk -f manip.awk voip2.result > temp.txt
rm voip2.result
mv temp.txt voip2.result

awk -f manip.awk voip3.result > temp.txt
rm voip3.result
mv temp.txt voip3.result

awk -f manip.awk data1.result > temp.txt
rm data1.result
mv temp.txt data1.result

awk -f manip.awk data2.result > temp.txt
rm data2.result
mv temp.txt data2.result
