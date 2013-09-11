class Show < ActiveRecord::Base
  extend Rmsc::Show
  belongs_to :coordinator
  belongs_to :venue
  has_many :attendances
  has_many :buyers, through: :attendance
  has_many :registrations
  has_many :exhibitors, through: :registrations

  def num_lines
    sql = <<-EOF
SELECT
  count(DISTINCT l.line)
FROM
  lines l,
  rooms r,
  registrations regs
WHERE
  l.room_id = r.id
  AND r.registration_id = regs.id
  AND regs.show_id = #{id}
EOF
    r = ActiveRecord::Base::connection.execute sql
    row = r.first
    row.first.last.to_i
  end

  def show_lines
    # @show_lines = Line.for_show(@current_show).collect do | line |
    #   [ line.line, line.room.room, exhibitor_name(line.room.registration.exhibitor) ]
    # end
    sql = <<-EOF
SELECT
  l.line,
  r.room,
  e.first_name || ' ' || e.last_name as exhibitor_name
FROM
  lines l,
  rooms r,
  registrations regs,
  exhibitors e
WHERE
  r.id = l.room_id
  AND regs.id = r.registration_id
  AND e.id = regs.exhibitor_id
  AND regs.show_id = #{id}
ORDER BY
  l.line ASC
EOF
    r = ActiveRecord::Base::connection.execute sql
    line_data = []
    r.each do | row |
      line_data << [ row['line'], row['room'], row['exhibitor_name'] ]
    end
    line_data
  end

end
