class ExhibitorsController < ApplicationController

  respond_to :json

  before_filter :must_have_exhibitor, only: [ :show, :update ]

  def index
    if params[:show_id].present?
      @exhibitors = Show.find(params[:show_id]).exhibitors.ordered
    else
      @exhibitors = Exhibitor.ordered
    end
  end

  def show
    # Nothing to do
  end

  def update
    address_info = exhibitor.address_info

    exhibitor.update_attributes params[:exhibitor]
    address_info.update_attributes params[:address_info]

    if exhibitor.valid? && address_info.valid?
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

  private

  def must_have_exhibitor
    @exhibitor = Exhibitor.where(id: params[:id]).first
    render json: { error: "Unable to find exhibitor with id: #{params[:id]}" }, status: 404 if @exhibitor.blank?
  end

end
