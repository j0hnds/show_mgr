# This script should be run using rails runner

class RMSCDb

  #
  # We use this to construct the block methods to query each of the 
  # base tables in the old database.
  #
  # Clever, no?
  #
  def method_missing(m, *args, &block)
    cmps = m.to_s.split("_")
    super unless cmps.first == 'each'
    each_row "SELECT * from #{cmps[1..-1].join("_")}", block
  end

  def close
    @connection.close unless @connection.nil?
  end

  def map_table_id(table, rmsc_id, new_id)
    table_id_map[table][rmsc_id] = new_id
  end

  def table_id(table, rmsc_id)
    table_id_map[table][rmsc_id]
  end

  private 

  def table_id_map
    @table_id_map ||= Hash.new { | h, key | h[key] = {} }
  end

  def each_row(sql, block)
    connection.exec sql do | result |
      result.each do | tuple |
        block.call tuple
      end
    end
  end

  def connection
    @connection ||= PG::Connection.open(dbname: 'RMSC', 
                                        host: 'localhost', 
                                        user: 'shoe_show', 
                                        password: 'shoe_show')
  end

end

rmscDb = RMSCDb.new

rmscDb.each_show do | tuple |
  puts "#{tuple['id']} -- #{tuple['description']}"
end

rmscDb.each_associate_attendance do | tuple |
  puts "#{tuple['show_id']} -- #{tuple['associate_id']}"
end

rmscDb.close
