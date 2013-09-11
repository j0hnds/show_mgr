class BookletPdf < Prawn::Document

  def initialize(show, exhibitors, line_count)
    super()
    @current_show = show
    @exhibitors = exhibitors
    @show_line_count = line_count
    render_booklet
  end

  def render_booklet
    render_title_page
    render_welcome_page
    render_exhibitor_cards
    render_lines_rooms
    render_thank_you
  end

  def render_title_page
    # put an image on the page
    image('public/images/mountains.jpeg', 
          :position => :center)
    text('Rocky Mountain', 
         :size => 30, 
         :style => :bold, 
         :align => :center)
    move_down 18
    text('Shoe Show', 
         :size => 30, 
         :style => :bold, 
         :align => :center)
    move_down 18
    text('Denver Market', 
         :size => 20, 
         :style => :bold, 
         :align => :center)
    move_down 36
    text("#{@current_show.start_date.strftime('%B %d')}-#{@current_show.end_date.strftime('%d, %Y')}", 
         :size => 18, 
         :style => :bold, 
         :align => :center)
    text(@current_show.venue.name, 
         :size => 18, 
         :style => :bold, 
         :align => :center)
    text(@current_show.venue.address_info.address_1, 
         :size => 18, 
         :style => :bold, 
         :align => :center)
    text("#{@current_show.venue.address_info.city}, #{@current_show.venue.address_info.state} #{@current_show.venue.address_info.postal_code}", 
         :size => 18, 
         :style => :bold, 
         :align => :center)
    move_down 36

    table([['Saturday', '9am to 5pm'],
           ['Sunday', '9am to 5pm']], 
          { :column_widths => { 
              0 => bounds.width * 0.5,
              1 => bounds.width * 0.5 },
            :cell_style => { :size => 16, 
              :borders => [], 
              :padding => 3 }
          } ) do
      columns(0).align = :right
    end

    move_down 18

    text('Friday & Monday - by Appointment only', 
         :size => 16, 
         :align => :center)

  end

  def render_welcome_page
# The welcome page
    start_new_page

    text('<u><b>Welcome to the Market</b></u>',
         :size => 20, 
         :inline_format => true,
         :align => :center)
    move_down 20

    text("Members of the Rocky Mountain Shoe Club welcome you to the #{@current_show.start_date.strftime('%B, %Y')} Denver Shoe Market.", 
         :size => 16)

    move_down 20

    text("We have over #{(@exhibitors.count/10)*10} Reps, marketing over #{(@show_line_count/10)*10} lines including shoes, socks, slippers and handbags.", 
         :size => 16)
    move_down 40

    text('<u><b>Lunch</b></u>',
         :size => 16, 
         :inline_format => true,
         :align => :center)
    move_down 20

    text("Lunch will be served Saturday and Sunday from 12:00pm to 1:30pm in the Aspen room and lounge area.", 
         :size => 16)
    move_down 20

    text("Retailers and exhibitors - We will be having a social hour on Saturday night in the Aspen room starting at 5:00pm.", 
         :size => 16)
    move_down 20

    text("Snacks and soft drinks will be provided.", 
         :size => 16)
    move_down 20

    text("Alcoholic beverages will be provided by the exhibitors.", 
         :size => 16)
    move_down 36

    text("NEXT SHOE MARKET", 
         :size => 26, 
         :style => :bold, 
         :align => :center)
    next_date_text = @current_show.next_start_date.nil? ? "" : "#{@current_show.next_start_date.strftime("%B %d")} and #{@current_show.next_end_date.strftime("%d, %Y")}"
    text(next_date_text, 
         :size => 26, 
         :style => :bold, 
         :align => :center)
    move_down 30

    text("Show Coordinator: #{display_name(@current_show.coordinator)}", 
         :size =>16, 
         :align => :center)
    text("Phone: #{@current_show.coordinator.phones.first.phone_number}", 
         :size => 16, 
         :align => :center)
    text("#{@current_show.coordinator.emails.first.address}", 
         :size => 16, 
         :align => :center)

  end

  def render_exhibitor_cards
    cell_width = (bounds.width / 2) - 6
    cell_height = (bounds.height / 4) - 12

    card_font_size = 12

    Rails.logger.error "## Cell width = #{cell_width}, Cell height = #{cell_height}"

    @exhibitors.each_slice(8) do | page_worth |
      start_new_page

      page_worth.each_with_index do | exhibitor, idx |
        col = idx % 2
        row = (idx < 2) ? 0 : (idx < 4) ? 1 : 2
        the_grid = [
                    # Row 0
                    bounds.top_left, 
                    [ bounds.right - cell_width,
                      bounds.top ],

                    # Row 1
                    [ bounds.left,
                      (bounds.top - cell_height) - 10 ],
                    [ bounds.right - cell_width,
                      (bounds.top - cell_height) - 10 ],

                    # Row 2
                    [ bounds.left,
                      (bounds.top - (2 * cell_height)) - 20 ],
                    [ bounds.right - cell_width,
                      (bounds.top - (2 * cell_height)) - 20 ],

                    # Row 3
                    [ bounds.left,
                      (bounds.top - (3 * cell_height)) - 30 ],
                    [ bounds.right - cell_width,
                      (bounds.top - (3 * cell_height)) - 30 ]
                   ]
    
        bounding_box(the_grid[idx], 
                         :width => cell_width, 
                         :height => cell_height) do
          text("#{display_name(exhibitor)}\n#{exhibitor_rooms(exhibitor.rooms_for_show(@current_show))}", 
                   :size => card_font_size,
                   :style => :bold)
          text("#{exhibitor_address(exhibitor)}\n", 
                   :size => card_font_size)
          phone = exhibitor.phones.detect { | phone | phone.phone_type == 'phone' }
          text("<b>Phone:</b> #{phone.phone_number}\n", 
                   :size => card_font_size, 
                   :inline_format => true) unless phone.blank?
          phone = exhibitor.phones.detect { | phone | phone.phone_type == 'fax' }
          text("<b>Fax:</b> #{phone.phone_number}\n", 
                   :size => card_font_size, 
                   :inline_format => true) unless phone.blank?
          phone = exhibitor.phones.detect { | phone | phone.phone_type == 'cell' }
          text("<b>Cell:</b> #{phone.phone_number}\n", 
                   :size => card_font_size, 
                   :inline_format => true) unless phone.blank?
          email = exhibitor.emails.first
          text("<b>Email:</b> #{email.address}\n", 
                   :size => card_font_size, 
                   :inline_format => true) unless email.blank?
          text("<b>Lines:</b> #{exhibitor.lines_for_show(@current_show).join(', ')}",
                   :size => card_font_size,
                   :inline_format => true)
        end
      end
    end
  end

  def render_lines_rooms
    start_new_page

    header = %w{ LINES ROOM EXHIBITOR }

    table([header] + @current_show.show_lines, 
          :header => true, 
          :column_widths => {
            0 => bounds.width * 0.5,
            1 => bounds.width * 0.15,
            2 => bounds.width * 0.35 },
          :row_colors => [ 'ffffff', 'eeeeee' ],
          :cell_style => { :size => 12 },
          :width => bounds.width) do | tbl |
      tbl.row(0).font_style = :bold
      tbl.row(0).background_color = 'cccccc'
    end

  end

  def render_thank_you
    start_new_page
    
    # Calculate and process the notes pages for filler.
    pg_number = page_number
    if pg_number % 4 > 0
      # puts "### Page number at thank you: #{pg_number}"
      mod_number = pg_number % 4
      # puts "### Mod of page number: #{mod_number}"
      num_notes_pages = (4 - mod_number)
      num_notes_pages.times do 
        text("NOTES", 
             :size => 20, 
             :style => :bold, 
             :align => :center)
        start_new_page
      end
    end

    # Now we can start the thank you
    text("THANK YOU", 
         :size => 20, 
         :style => :bold, 
         :align => :center)
    move_down 20
    text('FOR COMING TO THE SHOW', 
         :size => 20,
         :align => :center)
    move_down 100

    text('NEXT MARKET', 
         :size => 20, 
         :align => :center)
    move_down 20

    text("#{@current_show.next_start_date.strftime("%B %d")} and #{@current_show.next_end_date.strftime("%d, %Y")}",
         :size => 20,
         :align => :center)
    move_down 100

    text(@current_show.venue.name, 
         :size => 20, 
         :align => :center)
    text(venue_address(@current_show.venue), 
         :size => 20, 
         :align => :center)

    phone = @current_show.venue.phones.detect { | phone | phone.phone_type == 'phone' }
    text("Phone: #{phone.phone_number}", 
         :size => 20, 
         :align => :center) if phone.present?
    phone = @current_show.venue.phones.detect { | phone | phone.phone_type == 'fax' }
    text("Fax: #{phone.phone_number}", 
         :size => 20, 
         :align => :center) if phone.present?
  end

  def display_name(obj)
    "#{obj.first_name} #{obj.last_name}"
  end

  def exhibitor_rooms(rooms)
    room_label = "Room"
    room_label = room_label.pluralize if rooms.count > 1

    "#{room_label}: #{rooms.join(', ')}"
  end

  def exhibitor_address(exhibitor)
    address = exhibitor.address_info
    "#{address.address_1}\n#{address.city}, #{address.state}  #{address.postal_code}"
  end

  def venue_address(venue)
    address = venue.address_info
    "#{address.address_1}\n#{address.city}, #{address.state}  #{address.postal_code}"
  end


end
