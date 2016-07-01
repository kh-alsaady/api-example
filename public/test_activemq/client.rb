# require "socket"
# class Client
#   def initialize( server )
#     @server = server
#     @request = nil
#     @response = nil
#     listen
#     send
#     @request.join
#     @response.join
#   end

#   def listen
#     @response = Thread.new do


#       loop {
#         msg = @server.gets.chomp
#         puts "sdfsdfs#{msg}"
#       }
#     end
#   end

#   def send
#     puts "Enter the username:"
#     @request = Thread.new do
#       loop {
#         msg = $stdin.gets.chomp
#         @server.puts( msg + 'server' )

#       }
#       # while line = @server.gets   # Read lines from the socket
#       #     puts  line.chop      # And print with platform line terminator
#       #  end


#       # @server.print(@request)               # Send request
#       # response = @server.read              # Read complete response
#       # # Split response at first blank line into headers and body
#       # headers,body = response.split("\r\n\r\n", 2)
#       # print body                          # And display it
#     end
#   end
# end

# server = TCPSocket.open( "202.164.34.20", 4025 )
# Client.new( server )

require 'socket'
require "http/parser"


READ_CHUNK = 1024 * 4
socket = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM)
addr = Socket.pack_sockaddr_in(4025, '127.0.0.1')
# addr = Socket.pack_sockaddr_in(4025, '202.164.34.20')
socket.bind(addr)
socket.listen(Socket::SOMAXCONN)
socket.setsockopt(:SOCKET, :REUSEADDR, true)

puts "Server is listening on port = 4025"
loop do
    connection, addr_info = socket.accept

    parser = Http::Parser.new
    begin
      data = connection.readpartial(READ_CHUNK)
      puts "Buffer = #{data}"
      parser << data
    end until parser.headers

    connection.write("HTTP/1.1 200 \r\n")
    connection.write("Content-Type: text/html\r\n")
    connection.write("Status 200 \r\n")
    connection.write("Connection: close \r\n")
    connection.write("\r\n\r\n")
    connection.write("Hello World \r\n")
    connection.close
end

# require 'socket'      # Sockets are in standard library

# hostname = '202.164.34.20'
# port = 4025

# s = TCPSocket.open(hostname, port)
# begin rescue =>err

#       while line = s.gets   # Read lines from the socket

#         puts line.chop      # And print with platform line terminator
#       end

#       puts err.to_s
# end

# # s.close
