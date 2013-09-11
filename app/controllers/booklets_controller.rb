class BookletsController < ApplicationController

  def show
    @current_show = Show.find params[:id]

    @show_line_count = @current_show.num_lines

    @exhibitors = @current_show.exhibitors.ordered

    respond_to do | format |
      format.pdf do
        pdf = BookletPdf.new(@current_show, @exhibitors, @show_line_count)
        send_data(pdf.render, 
                  filename: "booklet_#{@current_show.id}.pdf", 
                  type: "application/pdf")
      end
    end
  end

end
