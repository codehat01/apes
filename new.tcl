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
set n2 [$ns node] ;
set n3 [$ns node] ;
set n4 [$ns node] ;
set n5 [$ns node] ;

# Create a duplex link between n0 and n1
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n3 $n4 1Mb 10ms DropTail
$ns duplex-link $n4 $n5 1Mb 10ms DropTail
$ns duplex-link $n0 $n5 1Mb 10ms DropTail

# Set up a TCP connection between n0 and n1
set tcp1 [new Agent/TCP]
$ns attach-agent $n0 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink1
$ns connect $tcp1 $sink1


set tcp2 [new Agent/TCP]
$ns attach-agent $n1 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $sink2
$ns connect $tcp2 $sink2

set tcp3 [new Agent/TCP]
$ns attach-agent $n2 $tcp3
set sink3 [new Agent/TCPSink]
$ns attach-agent $n3 $sink3
$ns connect $tcp3 $sink3

set tcp4 [new Agent/TCP]
$ns attach-agent $n3 $tcp4
set sink4 [new Agent/TCPSink]
$ns attach-agent $n4 $sink4
$ns connect $tcp4 $sink4

set tcp5 [new Agent/TCP]
$ns attach-agent $n4 $tcp5
set sink5 [new Agent/TCPSink]
$ns attach-agent $n5 $sink5
$ns connect $tcp5 $sink5

set tcp6 [new Agent/TCP]
$ns attach-agent $n5 $tcp6
set sink6 [new Agent/TCPSink]
$ns attach-agent $n0 $sink6
$ns connect $tcp6 $sink6
# Generate FTP traffic from n0 to n1
set ftp [new Application/FTP]
$ftp attach-agent $tcp1
$ftp set type_ FTP
$ns at 0.5 "$ftp start"

set ftp [new Application/FTP]
$ftp attach-agent $tcp2
$ftp set type_ FTP
$ns at 0.5 "$ftp start"

set ftp [new Application/FTP]
$ftp attach-agent $tcp3
$ftp set type_ FTP
$ns at 0.5 "$ftp start"

set ftp [new Application/FTP]
$ftp attach-agent $tcp4
$ftp set type_ FTP
$ns at 0.5 "$ftp start"

set ftp [new Application/FTP]
$ftp attach-agent $tcp5
$ftp set type_ FTP
$ns at 0.5 "$ftp start"

set ftp [new Application/FTP]
$ftp attach-agent $tcp6
$ftp set type_ FTP
$ns at 0.5 "$ftp start"

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

