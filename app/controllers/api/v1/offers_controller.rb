class Api::V1::OffersController < ApplicationController
  before_action -> { authorize_request(role: 'salesman') }, only: [:create]
  before_action -> { authorize_request(role: 'client') }, only: [:accept, :reject]

  def create
    offer = Offer.new(offer_params)
    offer.assign_products!(products_params)

    if offer.save
      render json: { status: 'Offer Created' }, status: 200
    else
      render json: { error: 'Unable to create the Offer' }, status: 400
    end
  end

  def accept
    offer = Offer.find(offer_params[:id])

    if offer.accept
      render json: { status: 'Offer Accepted' }, status: 200
    else
      render json: { error: 'Unable to accept the Offer' }, status: 400
    end
  end

  def reject
    offer = Offer.find(offer_params[:id])

    if offer.reject
      render json: { status: 'Offer Rejected' }, status: 200
    else
      render json: { error: 'Unable to accept the Offer' }, status: 400
    end
  end

  private

  def offer_params
    params.permit(:client_id, :id)
  end

  def products_params
    # TODO permit all expected attributes
    params[:products]
  end
end
