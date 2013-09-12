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

  def show_line_phones
    sql = <<-EOF
SELECT
  line,
  exhibitor_name,
  p.phone_number
FROM (

SELECT
  l.line,
  regs.exhibitor_id,
  e.first_name || ' ' || e.last_name as exhibitor_name
FROM
  registrations regs 
    INNER JOIN rooms r ON r.registration_id = regs.id
      INNER JOIN lines l ON l.room_id = r.id
        INNER JOIN exhibitors e ON e.id = regs.exhibitor_id
WHERE
  regs.show_id = #{id}) le 
  LEFT OUTER JOIN phones p ON p.phoneable_type = 'Exhibitor' AND p.phoneable_id = le.exhibitor_id AND p.phone_type = 'phone'
ORDER BY
  line ASC
EOF
    r = ActiveRecord::Base::connection.execute sql
    line_data = []
    r.each do | row |
      line_data << [ row['line'], row['exhibitor_name'], row['phone_number'] ]
    end
    line_data
  end

end
