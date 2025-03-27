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

# Create a duplex link between the nodes	
$ns duplex-link $n0 $n1 1Mb 10ms DropTail

# Set up a TCP connection
set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n1 $sink

$ns connect $tcp $sink

# Generate traffic
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP
$ns at 0.5 "$ftp start"

# Check node status (optional for debugging)
proc check_node_status {node} {
    puts "Node $node is active."
}

check_node_status $n0
check_node_status $n1

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
