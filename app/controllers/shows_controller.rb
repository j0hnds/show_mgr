class ShowsController < ApplicationController

  respond_to :json

  def index
    @shows = Show.order("start_date DESC")
  end

  def show
    @show = Show.find params[:id]
  end

end
