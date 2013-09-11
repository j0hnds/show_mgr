class Exhibitor < ActiveRecord::Base
  extend Rmsc::Exhibitor
  belongs_to :address_info
  has_many :phones, as: :phoneable
  has_many :emails, as: :emailable

  scope :ordered, -> { order('last_name ASC, first_name ASC') }

  def lines_for_show(show)
    sql = <<-EOF
      SELECT
        lns.line
      FROM
        registrations regs,
        rooms rms,
        lines lns
      WHERE
        rms.registration_id = regs.id
        AND lns.room_id = rms.id
        AND regs.exhibitor_id = #{id}
        AND regs.show_id = #{show.id}
     ORDER BY
        lns.order ASC
EOF
    r = ActiveRecord::Base::connection.execute sql
    r.map { | row | row['line'] }
  end

  def rooms_for_show(show)
    sql = <<-EOF
      SELECT
        rms.room
      FROM
        registrations regs,
        rooms rms
      WHERE
        rms.registration_id = regs.id
        AND regs.exhibitor_id = #{id}
        AND regs.show_id = #{show.id}
     ORDER BY
        room ASC
EOF
    r = ActiveRecord::Base::connection.execute sql
    r.map { | row | row['room'] }
  end
end
