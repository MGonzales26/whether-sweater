class Api::V1::ForecastsController < ApplicationController

  def show
    if params[:location]
      forecast = ForecastFacade.find_forecast(params[:location])
      if forecast != "ERROR"
        render json: ForecastSerializer.new(forecast)
      else
        render_bad_parameters
      end
    else
      render json: ErrorSerializer.new(:bad_request), status: :bad_request
    end
  end
end