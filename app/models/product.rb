class Product < ApplicationRecord
	validates :title, :user_id, presence: true
	validates :price, numericality: { greater_then_or_equal_to: 0 },
										presence: true
	belongs_to :user
	has_many :placements
	has_many :orders, through: :placements

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
		products = products.recent(params[:recent]) if params[:recent].present?

		products 	
	end
end
