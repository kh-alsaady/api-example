require 'rubygems'
require 'stomp'


message='this is test'
queue_name ="test"

queue = "/queue/#{queue_name}"
json = "#{message}"

client = Stomp::Client.new "system", "manager", "localhost", 61613, true

client.publish(queue,"this is test",{:persistent => true })

sleep 1
client.close
