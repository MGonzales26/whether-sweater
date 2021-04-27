class ApplicationController < ActionController::API

  rescue_from NoMethodError, with: :render_bad_parameters

  def render_bad_parameters
    error = { status: 400, error: 'Bad request'}
    render json: ErrorSerializer.new(error), status: :bad_request
  end
end
