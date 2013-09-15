class BuyerAttendeesController < ApplicationController

  def show
    @current_show = Show.find params[:id]

    @buyers = @current_show.buyers

    respond_to do | format |
      format.pdf do
        pdf = BuyerAttendeesPdf.new(@current_show, @buyers)
        send_data(pdf.render, 
                  filename: "buyer_attendees_#{@current_show.id}.pdf", 
                  type: "application/pdf")
      end
    end
  end

end
