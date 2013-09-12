class ExhibitorNameBadgesPdf < Prawn::Document
  include ReportHelper

  def initialize(registrations)
    super()
    @registrations = registrations
    render_name_badges
  end

  def render_name_badges
    column_gutter = 0 # 12
    row_gutter = 0 # 10
    cell_width = (bounds.width - (1 * column_gutter))  / 2
    cell_height = (bounds.height - (2 * row_gutter)) / 3

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
          indent 13.5 do
            text("#{exhibitor.first_name} #{exhibitor.last_name}", :size => 10)
            text(exhibitor_rooms(registration.rooms.pluck(:room)), :size => 10)
            text(registration.lines.collect(&:line).join(','), :size => 10)
          end
          stroke_bounds
        end
      end
    end
  end

end