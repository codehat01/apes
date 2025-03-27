# Create a new simulator
set ns [new Simulator]

# Define trace file and NAM file
set tracefile [open out.tr w]
set namfile [open out.nam w]

$ns trace-all $tracefile
$ns namtrace-all $namfile

# Define topology
set n0 [$ns node] ;# Create node 0
set n1 [$ns node] ;# Create node 1
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

# Create a duplex link between n0 and n1
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail
$ns duplex-link $n0 $n4 1Mb 10ms DropTail
$ns duplex-link $n0 $n5 1Mb 10ms DropTail

# Set up a UDP connection between n0 and n1
set udp1 [new Agent/UDP]
$ns attach-agent $n0 $udp1
set null1 [new Agent/Null]
$ns attach-agent $n1 $null1
$ns connect $udp1 $null1

set udp2 [new Agent/UDP]
$ns attach-agent $n1 $udp2
set null2 [new Agent/Null]
$ns attach-agent $n2 $null2
$ns connect $udp2 $null2

set udp3 [new Agent/UDP]
$ns attach-agent $n2 $udp3
set null3 [new Agent/Null]
$ns attach-agent $n3 $null3
$ns connect $udp3 $null3

set udp4 [new Agent/UDP]
$ns attach-agent $n3 $udp4
set null4 [new Agent/Null]
$ns attach-agent $n4 $null4
$ns connect $udp4 $null4

set udp5 [new Agent/UDP]
$ns attach-agent $n4 $udp5
set null5 [new Agent/Null]
$ns attach-agent $n5 $null5
$ns connect $udp5 $null5

set udp6 [new Agent/UDP]
$ns attach-agent $n5 $udp6
set null6 [new Agent/Null]
$ns attach-agent $n0 $null6
$ns connect $udp6 $null6

# Generate CBR traffic from n0 to n1
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1
$cbr1 set packetSize_ 512
$cbr1 set rate_ 1Mb
$ns at 0.5 "$cbr1 start"

set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $udp2
$cbr2 set packetSize_ 512
$cbr2 set rate_ 1Mb
$ns at 0.5 "$cbr2 start"

set cbr3 [new Application/Traffic/CBR]
$cbr3 attach-agent $udp3
$cbr3 set packetSize_ 512
$cbr3 set rate_ 1Mb
$ns at 0.5 "$cbr3 start"

set cbr4 [new Application/Traffic/CBR]
$cbr4 attach-agent $udp4
$cbr4 set packetSize_ 512
$cbr4 set rate_ 1Mb
$ns at 0.5 "$cbr4 start"

set cbr5 [new Application/Traffic/CBR]
$cbr5 attach-agent $udp5
$cbr5 set packetSize_ 512
$cbr5 set rate_ 1Mb
$ns at 0.5 "$cbr5 start"

set cbr6 [new Application/Traffic/CBR]
$cbr6 attach-agent $udp6
$cbr6 set packetSize_ 512
$cbr6 set rate_ 1Mb
$ns at 0.5 "$cbr6 start"

# Check node status (optional for debugging)
proc check_node_status {node} {
    puts "Node $node is active."
}

check_node_status $n0
check_node_status $n1
check_node_status $n2
check_node_status $n3
check_node_status $n4
check_node_status $n5

# Schedule the simulation end
$ns at 5.0 "finish"

# Define finish procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}

# Run the simulation
$ns run

