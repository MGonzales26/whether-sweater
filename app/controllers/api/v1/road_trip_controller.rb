class Api::V1::RoadTripController < ApplicationController
  before_action :verify_user

  def create
    road_trip = RoadTripFacade.find_road_trip(trip_params[:origin], trip_params[:destination])
    if road_trip == "ERROR"
      render json: ImpossibleTripSerializer.impossible_trip(trip_params[:origin], trip_params[:destination])
    else
      render json: RoadTripSerializer.new(road_trip)
    end
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