from socket import socket, AF_INET, SOCK_STREAM
sk=socket(AF_INET,SOCK_STREAM)
sk.bind(('0.0.0.0', 3000))
sk.listen()
conn,addr = sk.accept()
