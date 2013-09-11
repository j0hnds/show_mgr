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
    # puts "Table(#{table.inspect}), rmsc_id(#{rmsc_id.inspect}), new_id(#{new_id.inspect})"
  end

  def table_id(table, rmsc_id)
    table_id_map[table][rmsc_id].tap do | value |
     #  puts "Getting value for table(#{table.inspect}), rmsc_id(#{rmsc_id}) = #{value.inspect}"
    end
  end

  def table_ids(table)
    table_id_map[table]
  end

  def table_has_keys?(table)
    table_id_map[table].size > 0
  end

  def store_name(rmsc_show)
    store_name = nil
    connection.exec "SELECT name FROM chain WHERE chain_id = #{rmsc_show['chain_id']}" do | result |
      store_name = result[0][0]
    end
    store_name
  end

  def attendee_lines(show_id, attendee_type, attendee_id, &block)
    connection.exec "SELECT * FROM attendee_line WHERE show_id = #{show_id} AND attendee_type = #{attendee_type} AND attendee_id = #{attendee_id}" do | result |
      result.each do | tuple |
        block.call tuple
      end
    end
  end

  def exhibitor_associates(show_id, exhibitor_id, &block)
    sql = <<-EOF
    SELECT
      a.first_name,
      a.last_name
    FROM
      associate a,
      associate_attendance aa
    WHERE
      aa.associate_id = a.associate_id
      AND show_id = #{show_id}
      AND exhibitor_id = #{exhibitor_id}
EOF
    connection.exec sql do | result |
      result.each do | tuple |
        block.call tuple
      end
    end
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

class ShowManagerDb

  attr_reader :rmsc_db

  def initialize
    @rmsc_db = RMSCDb.new
  end

  def clean
    puts "Cleaning Show Mgr database..."
    Coordinator.destroy_all
    Venue.destroy_all

    Associate.destroy_all
    Line.destroy_all
    Room.destroy_all
    Registration.destroy_all
    
    Show.destroy_all

    Exhibitor.destroy_all

    Attendance.destroy_all
    Buyer.destroy_all
    Store.destroy_all

    AddressInfo.destroy_all
    Phone.destroy_all
    Email.destroy_all
  end

  MODEL_MAP = {
    'BuyerAttendance' => 'Attendance',
    'ExhibitorAttendance' => 'Registration'
  }

  def show_mgr_model(rmsc_model)
    return rmsc_model unless MODEL_MAP.has_key?(rmsc_model)
    MODEL_MAP[rmsc_model]
  end

  %w{ Show Exhibitor Store Buyer BuyerAttendance ExhibitorAttendance }.each do | model_name |
    define_method("convert_#{model_name.tableize}".to_sym) do
      puts "Converting #{model_name.tableize}..."
      rmsc_db.send("each_#{model_name.underscore}".to_sym) do | model_row |
        eval(show_mgr_model(model_name)).convert(rmsc_db, model_row)
      end
    end
  end

  def close
    rmsc_db.close
  end

end

sm = ShowManagerDb.new

sm.clean

sm.convert_shows
sm.convert_exhibitors
sm.convert_stores
sm.convert_buyers
sm.convert_buyer_attendances
sm.convert_exhibitor_attendances

sm.close

