class Api::V1::OffersController < ApplicationController
  before_action :authorize_request

  def create
    @offer = Offer.new(offer_params)
    @offer.assign_products!(products_params)

    if @offer.save
      render json: { status: 'Offer Created' }, status: 200
    else
      render json: { error: 'Unable to create the Offer' }, status: 400
    end
  end

  private

  def offer_params
    params.permit(:client_id)
  end

  def products_params
    # TODO permit all expected attributes
    params[:products]
  end

  def authorize_request
    @role = 'salesman'
    super
  end
end
