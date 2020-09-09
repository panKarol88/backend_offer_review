class ProductType < ApplicationRecord
  PRODUCT_ATTRIBUTES_ALLOWED = %(width height length material)

  has_many :products
  validate :product_attributes_structure_correctness

  private

  def product_attributes_structure_correctness
    # TODO validate fields to contain only PRODUCT_ATTRIBUTES_ALLOWED
  end
end
