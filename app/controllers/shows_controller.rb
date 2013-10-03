class ShowsController < ApplicationController

  respond_to :json

  before_filter :must_have_show, only: [ :show ]

  def index
    @shows = Show.order("start_date DESC")
  end

  def show
    # Do nothing
  end

  private

  def must_have_show
    @show = Show.where(id: params[:id]).first
    render json: { error: "Unable to find show with id: #{params[:id]}" }, status: 404 if @show.blank?
  end

end
