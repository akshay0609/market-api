class EnoughProductsValidator < ActiveModel::Validator
	def validate(record)
		record.placements do |placement|
			product = placement.product
			if placement.quantity > product.quantity
				record.errors["#{product.title}"] << "Is out of stock, just #{product.quantity} left"
			end
		end
	end
end