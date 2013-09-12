class ExhibitorNameBadgesController < ApplicationController

  def show
    @current_show = Show.find params[:id]
    @registrations = @current_show.registrations

    respond_to do | format |
      format.pdf do
        pdf = ExhibitorNameBadgesPdf.new(@registrations)
        send_data(pdf.render, 
                  filename: "exhibitor_name_badges_#{@current_show.id}.pdf", 
                  type: "application/pdf")
      end
    end
  end

end
