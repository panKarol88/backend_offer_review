class Offer < ApplicationRecord
  has_many :products

  def assign_products!(products_params)
    products_params.each do |product_param|
      self.products.new(product_param.permit!) # unsafe
    end
  end
end
