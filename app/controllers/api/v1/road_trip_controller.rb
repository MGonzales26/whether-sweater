class Api::V1::RoadTripController < ApplicationController
  before_action :verify_user

  def create
    road_trip = RoadTripFacade.find_road_trip(trip_params[:origin], trip_params[:destination])
    render json: RoadTripSerializer.new(road_trip)
  end
  private

  def trip_params
    JSON.parse(request.body.string, symbolize_names: true)
  end

  def verify_user
    user = User.find_by(api_key: trip_params[:api_key])
    if !user
      render json: { status: 401, error: "Unauthorized: Uh! Uh! Uh! You didn't say the magic word" }, status: 401
    else
      create
    end
  end
end