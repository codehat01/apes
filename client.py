import socket

def tcp_client():
    host = '127.0.0.1'
    port = 12345        

    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect((host, port))
    print(f"Connected to server at {host}:{port}")

    try:
        while True:
            message = input("Client: ")
            client_socket.send(message.encode())
            if message.lower() == 'exit':
                print("Connection closed by client.")
                break
            reply = client_socket.recv(1024).decode()
            if not reply or reply.lower() == 'exit':
                print("Connection closed by server.")
                break
            print(f"Server: {reply}")
    finally:
        client_socket.close()

tcp_client()
