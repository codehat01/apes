from scapy.all import *

spoofed_ip = "192.168.1.100"  
target_ip = "192.168.1.200"  

ip_layer = IP(src=spoofed_ip, dst=target_ip)

icmp_layer = ICMP()

send(ip_layer / icmp_layer)
