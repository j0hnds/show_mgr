class ExhibitorNameBadgesPdf < Prawn::Document
  include ReportHelper

  def initialize(registrations)
    super(left_margin: 0.6.cm,
          right_margin: 0.6.cm,
          top_margin: 1.in,
          bottom_margin: 1.in)
    @registrations = registrations
    render_name_badges
  end

  def render_name_badges
    column_gutter = 12 # 12
    row_gutter = 10 # 10
    # column_gutter = 0 # 12
    # row_gutter = 0 # 10
    cell_width = (bounds.width - (1 * column_gutter))  / 2
    cell_height = (bounds.height - (2 * row_gutter)) / 3

    Rails.logger.info "Cell Height: #{cell_height}, Cell Width: #{cell_width}"

    page_number = 0
    @registrations.each_slice(6) do | page_worth |
      page_number += 1
      start_new_page unless page_number == 1

      # Build up the page grid
      upper_lefts = (0..5).collect do | idx |
        col = idx % 2
        row = idx / 2
        [ bounds.left + ((col * cell_width) + (col * column_gutter)),
          bounds.top  - ((row * cell_height) + (row * row_gutter)) ]
      end

      page_worth.each_with_index do | registration, idx |
        exhibitor = registration.exhibitor
        col = idx % 2
        row = idx / 2
        bounding_box(upper_lefts[idx], :width => cell_width, :height => cell_height) do
          move_down 13.5
          x, y = [ 0, cell_height - 40.5 ]

          fill_color "ff0000"
          text_box("#{exhibitor.first_name} #{exhibitor.last_name}", 
                   at: [ x, y ],
                   size: 24,
                   width: cell_width,
                   height: cell_height,
                   align: :center)

          fill_color "000000"
          text_box(exhibitor_rooms(registration.rooms.pluck(:room)), 
                   at: [ x, y - 54 ],
                   size: 18,
                   width: cell_width,
                   height: cell_height,
                   align: :center)

          text_box(registration.lines.collect(&:line).join(','), 
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
