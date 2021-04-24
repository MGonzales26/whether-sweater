class Api::V1::UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: { status: 400, error: 'Invalid inputs: User has not been created'}, status: 400
    end
  end

  private 

  def user_params
    JSON.parse(request.body.string, symbolize_names: true)
  end
end