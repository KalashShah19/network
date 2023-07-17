#create a new simulator object

set ns [new Simulator]

#open the nam trace file

set nf [open out3.nam w]

$ns namtrace-all $nf

#define a 'finish' procedure

proc finish {} {

	global ns nf

	$ns flush-trace

	#close the trace file

	close $nf

	#execute nam on the trace file

	exec nam out3.nam &

	exit 0

}

#create two nodes

set n0 [$ns node]

set n1 [$ns node]

set n2 [$ns node]


#create a duplex link between the nodes

$ns duplex-link $n0 $n1  1Mb 10ms DropTail

$ns duplex-link $n1 $n2  1Mb 10ms DropTail

$ns duplex-link $n0 $n2  1Mb 10ms DropTail


#create a udp agent and attach it to node n0

set udp0 [new Agent/UDP]

$ns attach-agent $n0 $udp0

#Create a CBR traffic source and attach it to udp0

set cbr0 [new Application/Traffic/CBR]

$cbr0 set packetSize_ 500

$cbr0 set interval_ 0.005

$cbr0 attach-agent $udp0

#create a Null agent(a traffic sink) and attach it to node n1

set null0 [new Agent/Null]

$ns attach-agent $n1 $null0

#Connect the traffic source to the sink

$ns connect $udp0 $null0

#Schedule events for CBR traffic

$ns at 0.5 "$cbr0 start"

$ns at 4.5 "$cbr0 stop"

#call the finish procedure after 5 secs of simulated time

$ns at 5.0 "finish"

#run the simulation

$ns run
