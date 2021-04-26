class Api::V1::SalariesController < ApplicationController

  def index
    city_data = SalariesFacade.get_salaries(params[:destination])
    render json: SalariesSerializer.new(city_data)
  end
end