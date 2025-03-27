from scapy.all import sniff

# Packet handler function
def packet_callback(packet):
    if packet.haslayer("IP"):
        print(f"Source: {packet['IP'].src} -> Destination: {packet['IP'].dst} | Protocol: {packet['IP'].proto}")

# Sniff packets on the network
sniff(prn=packet_callback, store=False)
