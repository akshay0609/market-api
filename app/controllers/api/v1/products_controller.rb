class Api::V1::ProductsController < ApplicationController
	respond_to :json
	before_action :authenticate_with_token!,:only=> [:create, :update]

	def index
		products = Product.search(params).paginate(:page => params[:page], :per_page =>  params[:per_page])
		render json: products, meta: {
															pagination: {
																per_page: params[:per_page]
															}
														}
	end

	def show
		respond_with Product.find(params[:id])
	end

	def create
		
		product = current_user.products.new(product_params)
		product.pictures.new(image: product_images)
		if product.save
			render json: product, status: 201, location: [:api, product]
		else
			render json: {errors: product.errors}, status: 422
		end
	end

	def update
		product = current_user.products.find(params[:id])
		if product.update(product_params)
			render json: product, status: 200, location: [:api, product]
		else
			render json: {errors: product.errors}, status: 422
		end
	end

	def destroy
		product = current_user.products.find(params[:id])
		product.destroy
		head 204
	end

	private

	def product_params
		params.require(:product).permit(:title, :price, :published)
	end

	def product_images
		params[:product]
	end
end
