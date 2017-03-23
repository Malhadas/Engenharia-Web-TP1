class Server < Object
  require 'socket' # Get sockets to send/receive data

  require_relative 'Message' # Get message
  require_relative 'menu'
  require_relative 'Database' # Get database


  def initialize(port=2000,debug=0)
    @port     = port
    @debug    = debug
    @database = Database.new
    server = TCPServer.open(@port) # Socket to listen on given port

    loop do # Servers run forever
      puts('Waiting for Clients')
      Thread.fork(server.accept) do |client|
        client_thread(client) # Method to handle each client/thread
      end
      puts('Client found')

    end

    #ensure
     # @database.closeDB
  end

  def client_thread(client)

    send_message(client, Message.new(Message.HELLO,
                                     'Server',
                                     'Client',
                                     [Menu.menu(0)]
                                    )
                )
    loop {
      message = receive_message(client).split(';')
      if message
        puts('From: '+message[1]+', to: '+message[2])

        case message[0]

               when Message.REGISTER
                 args = message[3].strip.split('::')
                 send_message(client, Message.new(Message.REGISTER,
                                                  'Server',
                                                  'Client',
                                                  [@database.insert_or_replace_client(args[0], get_current_time, args[1],args[2])]
                              )
                 ) # Send Register success or failure

               when Message.LIST
                 puts case message[3].strip
                        when ''
                          send_message(client, Message.new(Message.LIST,
                                                           'Server',
                                                           'Client',
                                                           [@database.all_clients]
                                                          )
                                       ) # Send a Client list

                        else
                          send_message(client, Message.new(Message.LIST,
                                                           'Server',
                                                           'Client',
                                                           [@database.client_readings(message[3].strip)]
                                                           )
                                        ) # Send a list of a Client's readings
                      end

               when Message.CLOSE
                 puts('closing client '+client.to_s)
                 send_message(client, Message.new(Message.CLOSE,
                                                  'Server',
                                                  'Client',
                                                  [@database.last_readings(message[3].strip)+"\nNumber of Readings="+@database.count_last_readings(message[3].strip)]
                                                  )
                              ) # Send Closing remarks

               when Message.READING
                  res = message[3].strip.split('::')
                  case res[1]
                    when 'temperature'
                      puts '--> Received Temperature reading from client #'+res[0]+', Value='+res[2]+'ºC'
                      puts '    Value Read on: '+res[3]+'from Latitude='+res[4]+'and Longitude'+res[5]
                      @database.insert_reading(res[0], res[3], res[2], 'temperature')
                    when 'acoustic'
                      puts '--> Received Acoustic reading from client #'+res[0]+', Value='+res[2]+'Db'
                      puts '    Value Read on: '+res[3]+'from Latitude='+res[4]+'and Longitude'+res[5]
                      @database.insert_reading(res[0], res[3], res[2], 'acoustic')
                  end
             end
      end
    }
  end

  def send_message(client, message)
    client.puts(message.to_string) # send it to Client
    puts('Message Sent: '+message.to_string) if @debug==1
  end

  def receive_message(client)
    message = client.gets # Receive Message from client
    puts('Message Received: '+message) if @debug==1
    message
  end

  def get_current_time
    date = Time.new
    #get date in format -> YYYY-MM-DD HH:MM:SS.SSS
    return date.year.to_s + '-' + date.month.to_s + '-' + date.day.to_s + ' ' + date.hour.to_s + ':' + date.min.to_s + ':' + date.sec.to_s + ':' + '000'
  end

end


# Server process
Server.new