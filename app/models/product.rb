class Product < ApplicationRecord
	validates :title, :user_id, :description, presence: true
	validates :price, :quantity, numericality: { greater_then_or_equal_to: 0 },
										presence: true
	belongs_to :user
	has_many :placements
	has_many :orders, through: :placements
	has_many :pictures, as: :imageable, dependent: :destroy

	scope :filter_by_title, lambda { |keyword| 
		where("lower(title) LIKE ?", "%#{keyword.downcase}%")
	}

	scope :above_and_equal_to_price, lambda { |price| 
		where("price >= ? ", price)
	}

	scope :below_and_equal_to_price, lambda { |price| 
		where("price <= ? ", price)
	}

	scope :recent, -> {
		order(:updated_at)
	}

	def self.search(params = {})
		products = params[:id].present? ? Product.where(id: params[:id]) : Product.all

		products = products.filter_by_title(params[:title]) if params[:title].present?
		products = products.above_and_equal_to_price(params[:max_price].to_f) if params[:max_price].present?
		products = products.below_and_equal_to_price(params[:min_price].to_f) if params[:min_price].present?
		products = products.recent() if params[:recent].present?
		products = products.limit(params[:limit].to_i) if params[:limit].present?

		products 	
	end

	def build_images(images)
		images.each do |image|
			self.pictures.new(name: "data:image/jpeg;base64," + image['base64'])
		end
	end
end
