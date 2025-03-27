import socket


def tcp_server():
    
    host = '127.0.0.1'
    port = 12345
    socket_server=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    socket_server.bind((host,port))
    socket_server.listen(1)
    conn , addr = socket_server.accept()
    print(f"connection established{addr}")
    
    try:
        while True:
            data=conn.recv(1024).decode('utf-8')
            if not data or data.lower()=='exit':
                break
            print(f"client :{data}")
            reply = input("Server:")
            conn.send(reply.encode())
            if reply.lower()=='exit':
                print(f"connection closed")
                break
    
    finally:
        conn.close()
        socket_server.close()

tcp_server()
        
    
    
    
