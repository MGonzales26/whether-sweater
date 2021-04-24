class Api::V1::UsersController < ApplicationController

  def create
    user = User.create(user_params)
    render json: UserSerializer.new(user), status: 201
  end

  private 

  def user_params
    JSON.parse(request.body.string, symbolize_names: true)
  end
end