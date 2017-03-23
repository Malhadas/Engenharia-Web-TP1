class Database < Object

  require 'sqlite3'
  require_relative 'menu'

  def initialize
    #Connect to database
    @db = SQLite3::Database.new('DataBase.db')
    create_specific_database_TP1
  end

  def print_version
    @db.get_first_value 'SELECT SQLITE_VERSION()'
  end

  def create_table (name, attributes)
    @db.execute 'CREATE TABLE IF NOT EXISTS ' + name + ' (' + attributes + ');'
  end

  def insert_to_table (tableName, values)
    @db.execute 'INSERT INTO ' + tableName + values + ';'
  end

  def insert_or_replace (tableName, values)
    @db.execute ('INSERT OR REPLACE INTO '+tableName+values+';')
  end

  def execute_query (query)
    statement = @db.prepare query
    rs        = statement.execute
    result    = ''
    rs.each do |row|
      result = result+row.join("\s")
      result = result+"\n"
    end
    return result
  end

  def create_specific_database_TP1
    #date -> YYYY-MM-DD HH:MM:SS.SSS
    create_table('readings', 'client_id INTEGER,
                              read_date TEXT,
                              type TEXT,
                              value REAL,
                              PRIMARY KEY (client_id, read_date, type)')

    create_table('clients' , 'client_id SMALLINT NOT NULL PRIMARY KEY,
                              last_login_date TEXT'
                )

  end

  def insert_or_replace_client(id, date)
    insert_or_replace('clients',' (client_id, last_login_date) VALUES ('+id+", \""+date+"\")")
    return 'OK'
    rescue SQLite3::Exception
      return 'KO'
  end

  def insert_reading(client_id, date, value, type)
    insert_to_table('readings',' (client_id, read_date, type, value) VALUES ('+client_id+", \""+date+"\", \""+type+"\", \""+value+"\")")
  end

  def all_clients
    return Menu.list("| ALL CLIENTS\n| -----------\n| Client ID", execute_query('SELECT (client_id) FROM clients;'))
  end

  def client_readings(id)
    return Menu.list('| ALL READINGS FROM CLIENT: '+id+"\n| -------------------------\n| client id, read date, sensor type, value",
                     execute_query('SELECT * FROM readings WHERE client_id='+id)
                    )
  end

  def last_readings(id)
    return Menu.list('| READINGS FROM CLIENT: '+id+" ON THIS LOGIN\n| -----------------------------------\n| client id, read date, sensor type, value",
                     execute_query('SELECT * FROM readings WHERE client_id='+id+' AND (read_date >= (SELECT (last_login_date) FROM clients WHERE client_id = '+id+'))')
                    )
  end

  #def closeDB
   # ensure
    #  @db.close if @db
  #end

end

#def get_current_time(i)
 # date = Time.new
  #get date in format -> YYYY-MM-DD HH:MM:SS.SSS
  #return date.year.to_s + '-' + date.month.to_s + '-' + date.day.to_s + ' ' + date.hour.to_s + ':' + date.min.to_s + ':' + date.sec.to_s + ':' + i
#end

#d = Database.new
#puts d.insert_or_replace_client('1', get_current_time('000'))
#puts 'ola2'
#puts d.all_clients
#d.insert_reading('1', get_current_time('000'), '2', 'temperature')
#d.insert_reading('1', get_current_time('111'), '3', 'acoustic')
#puts d.client_readings('1')
#puts d.last_readings('1')
#d.closeDB

