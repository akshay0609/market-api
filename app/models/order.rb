class Order < ApplicationRecord
  belongs_to :user
  has_many :placements
  has_many :products, through: :placements
  before_validation :set_total! 
  accepts_nested_attributes_for :products
  
  validates :total, presence: true,
                      numericality: { greater_than_or_equal_to: 0 }

  validates :user_id, presence: true
  validates_with EnoughProductsValidator

  def set_total!
    self.total = 0
    self.placements.each do |placement|
      self.total += placement.product.price * placement.quantity
    end
  end

  def build_placements_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_ids_and_quantity|
      id, quantity = product_ids_and_quantity 
      self.placements.new(product_id: id, quantity: quantity.to_i)
    end
  end
end