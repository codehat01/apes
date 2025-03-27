from scapy.all import sniff

target_ip = "192.168.1.100"  # Replace with the desired IP

# Packet handler function
def packet_callback(packet):
    if packet.haslayer("IP") and (packet["IP"].src == target_ip or packet["IP"].dst == target_ip):
        print(f"Source: {packet['IP'].src} -> Destination: {packet['IP'].dst} | Protocol: {packet['IP'].proto}")

# Sniff packets for the specific IP
sniff(filter=f"ip host {target_ip}", prn=packet_callback, store=False)
