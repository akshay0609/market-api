class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total, :total_orders
  has_many :products, seralizer: OrderProductSerializer
  has_many :placements

  def total_orders 
  	current_user.orders.count
  end
end
