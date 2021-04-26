class Api::V1::SalariesController < ApplicationController

  def index
    if params[:destination]
      city_data = SalariesFacade.get_salaries(params[:destination])
      render json: SalariesSerializer.new(city_data) if city_data.salaries != []
    else
      render json: { status: 400, error: 'Invalid: Bad request'}, status: 400
    end
  end
end