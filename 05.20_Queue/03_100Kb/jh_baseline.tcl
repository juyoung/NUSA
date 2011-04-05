set ns [new Simulator]

set stoptime 300.0
set plottime 351.0 

##
# The CIR is choice of major parameter to observe in Differentiated service
# By chaing the parameter, we can observe to decrease the losses of vulnerable
# packets such as ones having real-time requirement.

#set cir0       30000; # committed information rate : policing parameter
#set cbs0       10000;
#set rate0    4000000;
#set cir1       30000; # committed information rate : policing parameter
#set cbs1       10000;
#set rate1    4000000;
#set pktSize      480; # packet size  

set FEdgeRouterNb  1; # Number of backend edge routers
set BEdgeRouterNb  1; # Number of backend edge routers

set SrcNodeNb      6; # Number of source nodes
set DstNodeNb      6; # Number of destination nodes
set NumberFlows    3; # Number of flows per source node 
set sduration  350.0; # Duration of simulation

set BW	       100Kb; # Bandwidth (slower)
set 10BW         1Mb; # 10*Bandwidth (faster)
set Prop      0.01ms; # Propagation delay
set Qsize         20; # Queue Size


#Define different colors for data flows (for NAM)
$ns color 0 Blue
$ns color 1 Red
$ns color 2 Green
$ns color 3 Brown
$ns color 4 Yellow
$ns color 5 Black

# Open the Trace file
set tf   [open out.tr w]; 
$ns trace-all $tf 

#Open the NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf

#Open parameter file
set pf [open param.txt w]
set space " "
set str $BW$space$Qsize
puts $pf $str
close $pf


# We define three files that will be used to trace the queue size, the bandwidth and losses at the bottleneck.
##########################
# Topology               #
##########################

# Step1: Instantiate nodes
# 6 source nodes from src(0) to src(5)
for {set i 0} {$i < $SrcNodeNb} {incr i} {
  set Src($i)  [$ns node]
}
                      
# 1 Front-end Edge router nodes from FEdge
set FEdge [$ns node]; 

# 1 Core router node
set Core [$ns node]

# 1 Back-end Edge router node
set BEdge [$ns node]; 

# 6 destination nodes from dst(0) to dst(5)
for {set i 0} {$i < $DstNodeNb} {incr i} {
  set Dst($i)  [$ns node]
}      
                

# Step2: Link nodes to form the given topology

##############################################################################
# Create links between core router, back-end router, and a destination node
# Assume B = 100 Kbps and thus 10*B = 1 Mbps
# Also, link propagation delay is negligible, 
# but we use 5 ms for that becasue of better NAM animation
# Another parameter to change will be the queue size (currently 100)
##############################################################################
# bottleneck link from core to back-end edge router
#set flink [lindex [$ns simplex-link $Core $BEdge 100kb 0.1ms dsRED/core] 0]
set flink [lindex [$ns simplex-link $Core $BEdge $BW $Prop DropTail] 0]
$ns queue-limit  $Core $BEdge  $Qsize
$ns simplex-link-op $Core $BEdge queuePos 0.5

# links from source nodes to a front-end edge router
for {set i 0} {$i < $SrcNodeNb} {incr i} {
  set j 1
  $ns simplex-link $Src($i) $FEdge $10BW $Prop DropTail
  $ns queue-limit $Src($i) $FEdge $Qsize
}

# links from a front-end edge router to core router
#$ns simplex-link $FEdge $Core 1Mb 0.1ms dsRED/edge
$ns simplex-link $FEdge $Core $10BW $Prop DropTail
$ns queue-limit $FEdge $Core $Qsize

# links from a back-end edge router to destination nodes
for {set i 0} {$i < $DstNodeNb} {incr i} {
  $ns simplex-link $BEdge $Dst($i) $10BW $Prop DropTail
  $ns queue-limit $BEdge $Dst($i) $Qsize
}


#Config Diffserv
# Obtain a handle to the dsRED queue from Core router to Backend Edge router 
#set qC2BEdge  [[$ns link $Core $BEdge] queue]; 
#$qC2BEdge meanPktSize $pktSize
#$qC2BEdge set numQueues_   3
#$qC2BEdge set NumPrec      3
#$qC2BEdge addPHBEntry  10 0 0 
#$qC2BEdge addPHBEntry  20 1 0 
#$qC2BEdge addPHBEntry  21 1 1 
#$qC2BEdge addPHBEntry  22 1 1 
#$qC2BEdge addPHBEntry  30 2 0 
#$qC2BEdge addPHBEntry  31 2 1 
#$qC2BEdge setMREDMode DROP 0
#$qC2BEdge setMREDMode DROP 1
#$qC2BEdge setMREDMode DROP 2
#$qC2BEdge configQ 0 0 15 45  0.5 0.01
#$qC2BEdge configQ 1 0 15 45  0.5 0.01
#$qC2BEdge configQ 1 1 15 45  0.5 0.01
#$qC2BEdge configQ 1 2 15 45  0.5 0.01
#$qC2BEdge configQ 2 0 15 45  0.5 0.01
#$qC2BEdge configQ 2 1 15 45  0.5 0.01


# put a policy on packets from Frontend edge router to Core router
#set qFE2C [[$ns link $FEdge $Core] queue]

# Set DS RED parameters from FEdge(1) to Core:
#$qFE2C meanPktSize 480
#$qFE2C set numQueues_  3; # 3 classes
#$qFE2C setNumPrec      3; # 3-level virtual queues

#$qFE2C addPolicyEntry [$Src(0) id] [$Dst(0) id] TokenBucket 10 $cir0 $cbs0 
#$qFE2C addPolicyEntry [$Src(1) id] [$Dst(1) id] TokenBucket 20 $cir0 $cbs0 
#$qFE2C addPolicyEntry [$Src(2) id] [$Dst(2) id] TokenBucket 20 $cir0 $cbs0 
#$qFE2C addPolicyEntry [$Src(3) id] [$Dst(3) id] TokenBucket 20 $cir0 $cbs0 
#$qFE2C addPolicyEntry [$Src(4) id] [$Dst(4) id] TokenBucket 30 $cir0 $cbs0 
#$qFE2C addPolicyEntry [$Src(5) id] [$Dst(5) id] TokenBucket 30 $cir1 $cbs1 

#$qFE2C addPolicerEntry TokenBucket 10 10
#$qFE2C addPolicerEntry TokenBucket 20 21 22
#$qFE2C addPolicerEntry TokenBucket 30 31

#$qFE2C addPHBEntry  10 0 0 
#$qFE2C addPHBEntry  20 1 0 
#$qFE2C addPHBEntry  21 1 1 
#$qFE2C addPHBEntry  22 1 2 
#$qFE2C addPHBEntry  30 2 0 
#$qFE2C addPHBEntry  31 2 1 

#$qFE2C configQ 0 0 10 20 0.1; # format: phyQno - virtQno - minTh - maxTh - maxDropProb
#$qFE2C configQ 1 0 10 20 0.1; # format: phyQno - virtQno - minTh - maxTh - maxDropProb
#$qFE2C configQ 1 1 10 20 0.1; # format: phyQno - virtQno - minTh - maxTh - maxDropProb
#$qFE2C configQ 1 2 10 20 0.1; # format: phyQno - virtQno - minTh - maxTh - maxDropProb
#$qFE2C configQ 2 0 10 20 0.1; # format: phyQno - virtQno - minTh - maxTh - maxDropProb
#$qFE2C configQ 2 1 10 20 0.1; # format: phyQno - virtQno - minTh - maxTh - maxDropProb

#$qFE2C printPolicyTable
#$qFE2C printPolicerTable
#$qFE2C printPHBTable
 
################################
# set flow monitor
################################
set monfile [open mon.tr w]
set fmon [$ns makeflowmon Fid]
$ns attach-fmon $flink $fmon
$fmon attach $monfile

################################
# set queue monitors
################################
#set tq1 [open out.queue1 w];
#$ns trace-queue $FEdge $Core $tq1

set tq2 [open out.queue2 w];
$ns trace-queue $Core $BEdge $tq2

# set UDP maximum packet size (default: 1000)
Agent/mUDP set packetSize_ 1500

# UDP Sources, destinations, connections
# Setup a UDP connection
set video [new Agent/mUDP]
#$video set_filename sndvideo
$ns attach-agent $Src(0) $video
set nullvideo [new Agent/mUdpSink]
$nullvideo set_filename video.result
$ns attach-agent $Dst(0) $nullvideo
$ns connect $video $nullvideo
$video set fid_ 0

# Setup a CBR over UDP connection
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $video
$cbr set packetSize_ 1280
$cbr set rate_ 256Kb
$cbr set random_ false

## Setup the pareto on/off source, parameterized by packet size,
## avg on time, avg off time, peak rate and pareto shape parameter
## VoIP_1
set voip1 [new Agent/mUDP]
#$voip1 set_filename sndvoip1
$ns attach-agent $Src(1) $voip1
set nullvoip1 [new Agent/mUdpSink]
$nullvoip1 set_filename voip1.result
$ns attach-agent $Dst(1) $nullvoip1
$ns connect $voip1 $nullvoip1
$voip1 set fid_ 1

set pareto1 [new Application/Traffic/Pareto]
$pareto1 set packetSize_ 320
$pareto1 set burst_time_ 400ms
$pareto1 set idle_time_ 400ms
$pareto1 set rate_ 64k
$pareto1 set shape_ 1.5

$pareto1 attach-agent $voip1

## VoIP_2
set voip2 [new Agent/mUDP]
#$voip2 set_filename sndvoip2
$ns attach-agent $Src(2) $voip2
set nullvoip2 [new Agent/mUdpSink]
$nullvoip2 set_filename voip2.result
$ns attach-agent $Dst(2) $nullvoip2
$ns connect $voip2 $nullvoip2
$voip2 set fid_ 2

set pareto2 [new Application/Traffic/Pareto]
$pareto2 set packetSize_ 320
$pareto2 set burst_time_ 40ms
$pareto2 set idle_time_ 360ms
$pareto2 set rate_ 256k
$pareto2 set shape_ 1.1

$pareto2 attach-agent $voip2

## VoIP_3
set voip3 [new Agent/mUDP]
#$voip3 set_filename sndvoip3
$ns attach-agent $Src(3) $voip3
set nullvoip3 [new Agent/mUdpSink]
$nullvoip3 set_filename voip3.result
$ns attach-agent $Dst(3) $nullvoip3
$ns connect $voip3 $nullvoip3
$voip3 set fid_ 3

set pareto3 [new Application/Traffic/Pareto]
$pareto3 set packetSize_ 320
$pareto3 set burst_time_ 313ms
$pareto3 set idle_time_ 2925ms
$pareto3 set rate_ 64k
$pareto3 set shape_ 1.1

$pareto3 attach-agent $voip3

## Setup three exponential on/off source, 
## parameterized by packet size, avg on time, avg off time and peak rate
## Data_1
set data1 [new Agent/mUDP]
#$data1 set_filename snddata1
$ns attach-agent $Src(4) $data1
set nulldata1 [new Agent/mUdpSink]
$nulldata1 set_filename data1.result
$ns attach-agent $Dst(4) $nulldata1
$ns connect $data1 $nulldata1
$data1 set fid_ 4

set exp1 [new Application/Traffic/Exponential]
$exp1 set packetSize_ 320
$exp1 set burst_time_ 400ms
$exp1 set idle_time_ 400ms
$exp1 set rate_ 64k

$exp1 attach-agent $data1

## Data_2
set data2 [new Agent/mUDP]
#$data2 set_filename snddata2
$ns attach-agent $Src(5) $data2
set nulldata2 [new Agent/mUdpSink]
$nulldata2 set_filename data2.result
$ns attach-agent $Dst(5) $nulldata2
$ns connect $data2 $nulldata2
$data2 set fid_ 5

set exp2 [new Application/Traffic/Exponential]
$exp2 set packetSize_ 320
$exp2 set burst_time_ 40ms
$exp2 set idle_time_ 360ms
$exp2 set rate_ 256k

$exp2 attach-agent $data2


#Define a 'finish' procedure
proc finish {} {
        global ns tf nf tq2
        $ns flush-trace
        close $nf
	#close $tq1
	close $tq2
	
	set utilpath "/home/cjhun/ns-allinone-2.34/icn_scenario/experiments/00.baseline/cjhun/util/"
	exec pwd > path.txt
 
        exec cp path.txt $utilpath
	exec cp param.txt $utilpath
        exec cp out.tr $utilpath
        exec cp video.result $utilpath
        exec cp voip1.result $utilpath
        exec cp voip2.result $utilpath
        exec cp voip3.result $utilpath
        exec cp data1.result $utilpath
        exec cp data2.result $utilpath

        exec rm out.nam

        exit 0
}         

$ns at [expr $stoptime - 0.01] "$fmon dump"
#$ns at [expr $stoptime - 0.001] "$qC2BEdge printStats"
$ns at $sduration "finish"

$ns at 1.0 "$cbr start"
$ns at 1.0 "$pareto1 start"
$ns at 1.0 "$pareto2 start"
$ns at 1.0 "$pareto3 start"
$ns at 1.0 "$exp1 start"
$ns at 1.0 "$exp2 start"

$ns at $stoptime "$cbr stop"
$ns at $stoptime "$pareto1 stop"
$ns at $stoptime "$pareto2 stop"
$ns at $stoptime "$pareto3 stop"
$ns at $stoptime "$exp1 stop"
$ns at $stoptime "$exp2 stop"

$ns at $plottime "close $tf"
$ns at $plottime "finish isn"

$ns run


