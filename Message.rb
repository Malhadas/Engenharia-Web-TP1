class Message < Object

  # message types
  HELLO    = '0' # Sent from Server when connection is established
  REGISTER = '1' # Sent from Client/Server when Client wishes to register
  CLOSE    = '2' # Sent from Client/Server when Client wishes to close connection
  READING  = '3' # Sent from Client to inform the Server about a new reading
  LIST     = '4' # Sent from Client/Server when Client wishes to consult a list

  def initialize(message_type, from, to, args)
    @message_type = message_type # message type
    @from         = from         # Message's origin
    @to           = to           # Message's destination
    @args         = args         # Message's optional arguments separated by the token '::''
  end

  def self.HELLO
    HELLO
  end

  def self.REGISTER
    REGISTER
  end

  def self.CLOSE
    CLOSE
  end

  def self.READING
    READING
  end

  def self.LIST
    LIST
  end

  def self.BYE
    BYE
  end

  def get_type
    @message_type
  end

  def get_from
    @from
  end

  def get_to
    @to
  end

  def get_args
    @args
  end

  def to_string
    aux = ''
    @args.each do |e|
      aux=aux+e+'::'
    end
    aux.gsub!("\n",'\n')
    aux = aux[0..-3];
    @message_type + ';' + @from + ';' + @to + ';' + aux;

  end

end

#m = Message.new(Message.HELLO,
#                'Server',
 #               'Client',
  #              [''])
#puts(m.to_string)
