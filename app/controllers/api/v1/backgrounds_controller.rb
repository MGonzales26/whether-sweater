class Api::V1::BackgroundsController < ApplicationController

  def show
    if params[:location] == ""
      render_bad_parameters
    else
      background = BackgroundFacade.get_background_image(params[:location])
      render json: BackgroundSerializer.new(background)
    end
  end
end