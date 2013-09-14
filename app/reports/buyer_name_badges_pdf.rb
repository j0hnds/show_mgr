class BuyerNameBadgesPdf < Prawn::Document
  include ReportHelper

  def initialize(buyers)
    super(left_margin: 0.6.cm,
          right_margin: 0.6.cm,
          top_margin: 1.in,
          bottom_margin: 1.in)
    @buyers = buyers
    render_name_badges
  end

  def render_name_badges
    column_gutter = 12 # 12
    row_gutter = 10 # 10
    cell_width = (bounds.width - (1 * column_gutter))  / 2
    cell_height = (bounds.height - (2 * row_gutter)) / 3

    Rails.logger.info "Cell Height: #{cell_height}, Cell Width: #{cell_width}"

    page_number = 0
    @buyers.each_slice(6) do | page_worth |
      page_number += 1
      start_new_page unless page_number == 1

      # Build up the page grid
      upper_lefts = (0..5).collect do | idx |
        col = idx % 2
        row = idx / 2
        [ bounds.left + ((col * cell_width) + (col * column_gutter)),
          bounds.top  - ((row * cell_height) + (row * row_gutter)) ]
      end

      page_worth.each_with_index do | buyer, idx |
        # exhibitor = registration.exhibitor
        col = idx % 2
        row = idx / 2
        bounding_box(upper_lefts[idx], :width => cell_width, :height => cell_height) do
          move_down 13.5
          x, y = [ 0, cell_height - 40.5 ]

          text_box("#{buyer.first_name} #{buyer.last_name}", 
                   at: [ x, y ],
                   size: 24,
                   width: cell_width,
                   height: cell_height,
                   align: :center)

          text_box(buyer.store.name, 
                   at: [ x, y - 54 ],
                   size: 18,
                   width: cell_width,
                   height: cell_height,
                   align: :center)

          store_address = buyer.store.address_info
          text_box("#{store_address.city}, #{store_address.state}", 
                   at: [ x, y - 94.5 ],
                   size: 18,
                   width: cell_width,
                   height: cell_height,
                   align: :center)


        end
      end
    end
  end

end
