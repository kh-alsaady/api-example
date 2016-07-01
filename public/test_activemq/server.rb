require 'rubygems'
require 'stomp'
require "socket"
class Server
  def initialize( port, ip )
    @server = TCPServer.open( ip, port )
    @connections = Hash.new
    @rooms = Hash.new
    @clients = Hash.new
    @connections[:server] = @server
    @connections[:rooms] = @rooms
    @connections[:clients] = @clients
    run
  end

  def run
    loop {
       Thread.start(@server.accept) do | client |
         nick_name = client.gets.chomp.to_sym

         @connections[:clients].each do |other_name, other_client|
            if nick_name == other_name || client == other_client
               client.puts "This username already exist"
               Thread.kill self
             end
         end


            puts "#{nick_name}\n"
            open("/var/www/html/obtcar/trunk/obd/public/tcplogs.txt", 'a') { |f|
                f.puts "#{nick_name}\n"
                message_broker_client_producer("#{nick_name}", "test12")  #call publisher function

           }


        @connections[:clients][nick_name] = client
        client.puts "Connection established, Thank you for joining! Happy chatting"
        # listen_user_messages( nick_name, client )
      end
    }.join
  end



  def listen_user_messages( username, client )
    loop {
      msg = client.gets.chomp


      @connections[:clients].each do |other_name, other_client|
        unless other_name == username


          other_client.puts "#{username.to_s}: #{msg}"
        end
      end
    }
  end
#Message publish using activemq/stomp

  def message_broker_client_producer( message, queue_name )

      queue = "/topic/#{queue_name}"
      json = "#{message}"

      client = Stomp::Client.new "system", "manager", "localhost", 61613, true

      client.publish(queue,json,{:persistent     => true })

      sleep 1
      client.close
  end


end
Server.new(4025, "127.0.0.1" )
# Server.new(4025, "202.164.34.20" )
