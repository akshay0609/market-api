class ProductSerializer < ActiveModel::Serializer
	cache key: 'product'

  attributes :id, :title, :description, :price, :published
  has_one :user
end
