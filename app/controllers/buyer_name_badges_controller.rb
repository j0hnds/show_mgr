class BuyerNameBadgesController < ApplicationController

  def show
    @buyers = Buyer.all

    respond_to do | format |
      format.pdf do
        pdf = BuyerNameBadgesPdf.new(@buyers)
        send_data(pdf.render, 
                  filename: "buyer_name_badges.pdf", 
                  type: "application/pdf")
      end
    end
  end

end
