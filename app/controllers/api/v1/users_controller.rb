  class Api::V1::UsersController < ApplicationController
  respond_to :json
  before_action :set_user, only: [:update, :destroy]
  before_action :authenticate_with_token!, only: [:update, :destroy]

  def show
    render json: User.find(params[:id])
  end

  def create
  	@user = User.new(user_params)
  	if @user.valid?
  		@user.save
  		render json: @user, status: 201, location: [:api, @user]
  	else
  		render json: {errors: @user.errors}, status: 422
  	end
  end

  def update
  	if current_user.update(user_params)
			render json: @user, status: 200, location: [:api, @user]
		else
			render json: {errors: @user.errors}, status: 422
		end	
  end

  def destroy
  	@user.destroy
  	render json: {message: "deleted successfully"}, status: 200, location: [:api, @user]
  end

  private

  def user_params
  	params.require(:user).permit(:name, :email,:password,:password_confirmation);
  end

  def set_user
  	@user = current_user
  end
end
