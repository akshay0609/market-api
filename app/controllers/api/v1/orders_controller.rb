class Api::V1::OrdersController < ApplicationController
	before_action :authenticate_with_token!
	respond_to :json

	def index
		orders = current_user.orders.paginate(:page => params[:page], :per_page => params[:per_page])
		render json: orders, meta: {
													pagination: {
														per_page: params[:per_page]
													}
												}
	end

	def show
		respond_to current_user.orders.find(params[:id])
	end

	def create
		order = current_user.orders.new
		order.build_placements_with_product_ids_and_quantities(order_params)
		if order.save
			OrderMailer.delay.send_confirmation(order)
			render json: order, status: 201, location: [:api, current_user, order]
		else
			render json: {errors: order.errors}, status: 422
		end
	end

	private

	def order_params
		# params.require(:order).permit(:product_ids)[:product_ids].tr('[]', '').split(',').map(&:to_i)
 		# params.require(:order).permit(:product_ids => [])
 		params[:order][:product_and_quantity].tr('[]', '').split(',').map(&:to_i).each_slice(2).to_a
	end
end