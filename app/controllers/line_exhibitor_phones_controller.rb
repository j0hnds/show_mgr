class LineExhibitorPhonesController < ApplicationController

  def show
    @current_show = Show.find params[:show_id]

    respond_to do | format |
      format.pdf do
        pdf = LineExhibitorPhonePdf.new(@current_show)
        send_data(pdf.render, 
                  filename: "exhibitor_name_badges_#{@current_show.id}.pdf", 
                  type: "application/pdf")
      end
    end
  end  

end
