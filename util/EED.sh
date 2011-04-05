# generates jitter files for each traffic

awk -f EED.awk video.result > video.EED
awk -f jitter.awk video.result > video.jitter

awk -f EED.awk voip1.result > voip1.EED
awk -f jitter.awk voip1.result > voip1.jitter

awk -f EED.awk voip2.result > voip2.EED
awk -f jitter.awk voip2.result > voip2.jitter

awk -f EED.awk voip3.result > voip3.EED
awk -f jitter.awk voip3.result > voip3.jitter

awk -f EED.awk data1.result > data1.EED
awk -f jitter.awk data1.result > data1.jitter

awk -f EED.awk data2.result > data2.EED
awk -f jitter.awk data2.result > data2.jitter

cat video.EED >> results.EED
cat voip1.EED >> results.EED
cat voip2.EED >> results.EED
cat voip3.EED >> results.EED
cat data1.EED >> results.EED
cat data2.EED >> results.EED

rm video.EED
rm voip1.EED
rm voip2.EED
rm voip3.EED
rm data1.EED
rm data2.EED
