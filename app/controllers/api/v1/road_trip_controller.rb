class Api::V1::RoadTripController < ApplicationController

  def create
    road_trip = RoadTripFacade.find_road_trip(trip_params[:origin], trip_params[:destination])
    render json: RoadTripSerializer.new(road_trip)
  end
  private

  def trip_params
    JSON.parse(request.body.string, symbolize_names: true)
  end
end