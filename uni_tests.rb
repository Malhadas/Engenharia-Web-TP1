class UniTests < Object

  require_relative 'Message'
  require_relative 'Database'

  #Test Message class
  def self.test_message
    m = Message.new(Message.HELLO,
                    'Server',
                    'Client',
                    ['test'])
    puts (m.to_string == '0;Server;Client;test')
  end

  #Test Database class
  def self.test_database
    d = Database.new('TestDB.db')
    date = Time.new
    #get date in format -> YYYY-MM-DD HH:MM:SS.SSS
    data =  date.year.to_s + '-' + date.month.to_s + '-' + date.day.to_s + ' ' + date.hour.to_s + ':' + date.min.to_s + ':' + date.sec.to_s + ':'
    d.insert_or_replace_client('1', data+'000', '23', '25')
    d.all_clients
    d.insert_reading('1', data+'345', '2', 'temperature')
    d.insert_reading('1', data+'500', '3', 'acoustic')
    d.client_readings('1')
    d.last_readings('1')
    d.count_last_readings('1')
    puts true

  rescue SQLite3::Exception => e
      puts e
      puts false
  end

end

UniTests.test_message
UniTests.test_database