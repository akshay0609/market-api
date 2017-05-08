class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total
  has_many :products, seralizer: OrderProductSerializer
end
