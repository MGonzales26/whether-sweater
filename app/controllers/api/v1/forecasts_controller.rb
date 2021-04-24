class Api::V1::ForecastsController < ApplicationController

  def show
    if params[:location]
      forecast = ForecastFacade.find_forecast(params[:location])
      render json: ForecastSerializer.new(forecast) if forecast != "ERROR"
    else
      render json: ErrorSerializer.new(:bad_request), status: :bad_request
    end
  end
end