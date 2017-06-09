require 'base64'

class ProductSerializer < ActiveModel::Serializer
	cache key: 'product'

  attributes :id, :title, :description, :price, :published, :adds_image, :quantity, :total_product
  has_many :pictures
  has_one :user

  def adds_image
  	# hostname = "http://10.0.28.241:3000/"
    # return hostname + object.pictures[0].name.url
    return "http://res.cloudinary.com/dzrgwhm1s/" + object.pictures[0].name.identifier	
  end

  def total_product
    Product.count
  end
end
