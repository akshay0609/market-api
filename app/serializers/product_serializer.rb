class ProductSerializer < ActiveModel::Serializer
	cache key: 'product'

  attributes :id, :title, :price, :published
  has_one :user
end
