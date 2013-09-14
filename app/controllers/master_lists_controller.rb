class MasterListsController < ApplicationController

  def show
    @buyers = Buyer.all

    respond_to do | format |
      format.pdf do
        pdf = MasterListPdf.new(@buyers)
        send_data(pdf.render, 
                  filename: "master_list.pdf", 
                  type: "application/pdf")
      end
    end
  end

end
