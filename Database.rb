class Database < Object

  require 'sqlite3'
  require_relative 'menu'

  def initialize(path='DataBase.db')
    #Connect to database
    @db = SQLite3::Database.new(path)
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
                              latitude REAL,
                              longitude REAL,
                              last_login_date TEXT'
                )

  end

  def insert_or_replace_client(id, date, latitude, longitude)
    insert_or_replace('clients',' (client_id, latitude, longitude, last_login_date) VALUES ('+id+', '+latitude+', '+longitude+", \""+date+"\")")
    return 'OK'
  rescue SQLite3::Exception => e
      puts e
      return 'KO'
  end

  def insert_reading(client_id, date, value, type)
    insert_to_table('readings',' (client_id, read_date, type, value) VALUES ('+client_id+", \""+date+"\", \""+type+"\", \""+value+"\")")
  end

  def all_clients
    return Menu.list("| ALL CLIENTS\n| -----------\n| Client ID, latitude, longitude", execute_query('SELECT client_id, latitude, longitude FROM clients;'))
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

  def count_last_readings(id)
    return execute_query('SELECT COUNT(*) FROM readings WHERE client_id='+id+' AND (read_date >= (SELECT (last_login_date) FROM clients WHERE client_id = '+id+'))')
  end

  #def closeDB
   # ensure
    #  @db.close if @db
  #end

end

