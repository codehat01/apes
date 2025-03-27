import socket

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind(("0.0.0.0", 8080))
server_socket.listen(1)

print("Server listening on port 8080...")

conn, addr = server_socket.accept()
print(f"Connection from {addr}")

data = conn.recv(1024).decode()
print(f"Received: {data}")

conn.send("Hello from server!".encode())

conn.close()
server_socket.close()