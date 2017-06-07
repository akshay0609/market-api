class Picture < ApplicationRecord
	belongs_to :imageable, polymorphic: true

	mount_base64_uploader :name, PictureUploader
	# , file_name: -> (image_name) { image_name }
end
