class ExhibitorsController < ApplicationController

  respond_to :json

  def index
    if params[:show_id].present?
      @exhibitors = Show.find(params[:show_id]).exhibitors.ordered
    else
      @exhibitors = Exhibitor.ordered
    end
  end

  def show
    @exhibitor = Exhibitor.find params[:id]
  end

  def update
    @exhibitor = Exhibitor.find params[:id]
    address_info = @exhibitor.address_info

    @exhibitor.update_attributes params[:exhibitor]
    address_info.update_attributes params[:address_info]

    if @exhibitor.valid? && address_info.valid?
      render :show
    else
      render json: @exibitor.errors.messages.merge(address_info.errors.message)
    end
  end

  def create
    @exhibitor = Exhibitor.new params[:exhibitor]
    @exhibitor.address_info = AddressInfo.new params[:address_info]

    if @exhibitor.valid? && @exhibitor.address_info.valid?
      render :show
    else
      render json: @exibitor.errors.messages.merge(@exhibitor.address_info.errors.message)
    end
  end

end
