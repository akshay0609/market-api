class Api::V1::ProductsController < ApplicationController
	respond_to :json
	before_action :authenticate_with_token!,:only=> [:create, :update]

	def index
		if params[:page].present? && params[:per_page].present?
			products = Product.search(params).paginate(:page => params[:page], :per_page =>  params[:per_page])
		else
			products = Product.search(params)
		end

		render json: products, meta: {
															pagination: {
																per_page: params[:per_page]
															}
														}
	end

	def show
		render json: Product.find(params[:id])
	end

	def create
		product = current_user.products.new(product_params)
		product.build_images(params[:images])
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
		params.require(:product).permit(:title, :price, :published, :description, :quantity)
	end
end
