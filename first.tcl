#create a new simulator object

set ns [new Simulator]

#open the nam trace file

set nf [open out.nam w]

$ns namtrace-all $nf

#define a 'finish' procedure

proc finish {} {

	global ns nf

	$ns flush-trace

	#close the trace file

	close $nf

	#execute nam on the trace file

	exec nam out.nam &

	exit 0
	
}

#create two nodes

set n0 [$ns node]

set n1 [$ns node]

#create a duplex link between the nodes

$ns duplex-link $n0 $n1 1Mb 10ms DropTail