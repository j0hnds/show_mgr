class MasterListPdf < Prawn::Document

  def initialize(buyers)
    super(page_layout: :landscape,
          left_margin: 0.6.cm,
          right_margin: 0.6.cm,
          top_margin: 1.in,
          bottom_margin: 0.5.in)
    
    @buyers = buyers
    set_up_headers
    render_master_list
  end

  def set_up_headers
    repeat :all do
      bounding_box [bounds.left, bounds.top + 0.5.in], :width => bounds.width do
        table([[ 'ATTENDEE LIST', 'ROCKY MOUNTAIN SHOE SHOW', 'MASTER LIST']],
              cell_style: { size: 12, borders: [] },
              width: bounds.width) do | tbl |
          tbl.row(0).font_style = :bold
          tbl.column(1).align = :center
          tbl.column(2).align = :right
        end
      end
    end
  end

  def render_master_list
    header = [ 'Name', 'Store Name', 'Store Address', 'City', 'State', 'ZIP' ]
    buyers = @buyers.map do | buyer |
      address = buyer.store.address_info
      [ "#{buyer.first_name} #{buyer.last_name}",
        buyer.store.name,
        address.address_1,
        address.city,
        address.state,
        address.postal_code ]
    end.sort { | a, b | a[1] <=> b[1] }
    
    table([ header ] + buyers,
          header: true,
          column_widths: {
            0 => bounds.width * 0.15,
            1 => bounds.width * 0.25,
            2 => bounds.width * 0.25,
            3 => bounds.width * 0.20,
            4 => bounds.width * 0.08,
            5 => bounds.width * 0.07 },
          cell_style: { size: 10, borders: [] },
          width: bounds.width) do | tbl |
      tbl.row(0).font_style = :bold
    end
  end

end
