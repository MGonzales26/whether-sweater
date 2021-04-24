class Api::V1::SessionsController < ApplicationController
  
  def create
    user = User.find_by(email: user_params[:email])
    if user&.authenticate(user_params[:password])
      render json: UserSerializer.new(user)
    else
      render json: { status: 400, error: 'Invalid: User can not login'}, status: 400
    end
  end

 private 

  def user_params
    JSON.parse(request.body.string, symbolize_names: true)
  end
end