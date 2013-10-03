class ShowBaseController < ApplicationController
  attr_reader :current_show

  before_filter :must_have_show

  private 

  def must_have_show
    @current_show = Show.where(id: params[:show_id]).first
    render json: { error: "Unable to find show with id: #{params[:show_id]}" }, status: 404 if @current_show.blank?
  end

end
