class LineExhibitorPhonePdf < Prawn::Document

  def initialize(current_show)
    super()
    @current_show = current_show
    render_report
  end

  def render_report
    header = %w{ Line Exhibitor Phone }

    table([header] + @current_show.show_line_phones,
          :header => true,
          :column_widths => {
            0 => bounds.width * 0.5,
            1 => bounds.width * 0.30,
            2 => bounds.width * 0.20 },
          :row_colors => [ 'ffffff', 'eeeeee' ],
          :cell_style => { :size => 10 },
          :width => bounds.width) do
      row(0).font_style = :bold
      row(0).background_color = 'cccccc'
    end
  end

end
