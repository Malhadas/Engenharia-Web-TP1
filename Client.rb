class Client < Object
  require 'socket'  # Get sockets to send/receive data

  require_relative 'Message' # Get message
  require_relative 'menu'
  require_relative 'Xdk'

  def initialize (hostname = 'localhost', port = 2000, debug = 0)
    @xdk      = Xdk.new
    puts 'Write your ID'
    @id       = STDIN.gets.chop
    puts 'Write your latitude'
    @latitude       = STDIN.gets.chop
    puts 'Write your longitude'
    @longitude       = STDIN.gets.chop
    @debug    = debug
    @hostname = hostname
    @port     = port
    puts('Connecting to Server')
    @socket   = TCPSocket.open(hostname, port)
    @open=1
    main_menu
  end

  def main_menu
    loop {
      message = receive_message.split(';')
      if message
        puts('From: '+message[1]+', to: '+message[2])
        case message[0]
               when Message.HELLO
                    puts(message[3].gsub!('\n',"\n"))
                    STDIN.gets#.chop to take out new line
                    send_message(Message.new(Message.REGISTER,
                                             'Client',
                                             'Server',
                                             [@id.to_s, @latitude.to_s, @longitude.to_s]
                                            )
                                 ) # Send a Register Request

               when Message.REGISTER
                 case (message[3].strip)
                   when 'OK'
                     puts('Register Success')
                     sending_menu
                   when 'KO'
                     puts('Register Failure. Closing.')
                     @socket.close  # Close the socket when done
                 end

               when Message.LIST
                 puts(message[3].gsub!('\n',"\n"))
                 puts('Press ENTER to go back to the menu.')
                 STDIN.gets#.chop to take out new line
                 sending_menu

               when Message.CLOSE
                 @open=0
                 puts(message[3].gsub!('\n',"\n"))
                 puts('Press ENTER to terminate.')
                 STDIN.gets#.chop to take out new line
                 @socket.close  # Close the socket when done
                 return

             end
      end
    }
  end

  def sending_menu
    puts(Menu.menu(1))
    puts case STDIN.gets.chop
           when '1'
             send_message(Message.new(Message.LIST,
                                      'Client',
                                      'Server',
                                      ['']
                                      )
                          ) # Send a List Request for a list of all clients
           when '2'
             puts('Please specify the ID of the Client: ')
             option = STDIN.gets.chop
             send_message(Message.new(Message.LIST,
                                      'Client',
                                      'Server',
                                      [option.to_s]
             )
             ) # Send a List Request for readings on a specific client

           when '3'
             Thread.new {
               simulate(Xdk.TEMPERATURE,'temperature',30)
             }
             sending_menu


           when '4'
             Thread.new {
               simulate(Xdk.ACOUSTIC,'acoustic',1)
             }
             sending_menu

           when '5'
                send_message(Message.new(Message.CLOSE,
                                         'Client',
                                         'Server',
                                         [@id.to_s]
                                         )
                              ) # Send a Close Request

         end
  end


  def simulate(simulation_type, identifier, time)
    while @open==1 do
      puts 'Sending '+identifier if @debug==1
      value = @xdk.simulate_new(simulation_type)
      send_message(Message.new(Message.READING,
                             'Client',
                             'Server',
                             [@id.to_s,identifier,value.to_s, get_current_time, @latitude.to_s, @longitude.to_s]
                             )
                 )
      sleep(time) #wait for the specified seconds
    end
  end

  def send_message(message)
    @socket.puts(message.to_string) # Serialize Message and send it to Client
    puts('Message Sent: '+message.to_string) if @debug==1
  end

  def receive_message
    message = @socket.gets # Receive Message from client and deserialize it
    puts('Message Received: '+message) if @debug==1
    message
  end

  def get_current_time
    date = Time.new
    #get date in format -> YYYY-MM-DD HH:MM:SS.SSS
    return date.year.to_s + '-' + date.month.to_s + '-' + date.day.to_s + ' ' + date.hour.to_s + ':' + date.min.to_s + ':' + date.sec.to_s + ':' + '000'
  end

end

#client process
Client.new()