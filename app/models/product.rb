class Product < ApplicationRecord
  belongs_to :product_type
  belongs_to :offer

  validate :quantity_correctness
  validate :product_attributes_correctness
  before_create :calculate_price

  private

  def quantity_correctness
    unless quantity.between?(product_type.min_quantity, product_type.max_quantity)
      errors.add(:quantity, "Quantity has to be in range of #{product_type.min_quantity}-#{product_type.max_quantity}")
    end
  end

  def product_attributes_correctness
    # TODO validate correctness of attribute keys
    # TODO validate if attributes values are in range of product type declaration
  end

  def calculate_price
    # TODO pack this logic into some service (OR polymorphic products?)
    # TODO validate presence of each attribute

    self.price = case product_type.name
                 when 'MailerBox'
                   (product_attributes['width'] + product_attributes['height'] + product_attributes['length']) * 0.1 * quantity
                 when 'PolyMailer'
                   (product_attributes['width'] + product_attributes['height']) * (product_attributes['material'] == 'transparent' ? 0.15 : 0.1) * quantity
                 else
                   raise 'Unsupported product type'
                 end
  end
end
