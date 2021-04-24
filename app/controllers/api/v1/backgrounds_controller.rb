class Api::V1::BackgroundsController < ApplicationController

  def show
    # require 'pry'; binding.pry
    conn = Faraday.new('https://api.unsplash.com')
    result = conn.get('/search/photos') do |f|
      f.params['client_id'] = ENV['UNSPLASH_API_KEY']
      f.params['query'] = "#{params[:location]} landmark"
    end

    data = JSON.parse(result.body, symbolize_names: true)

    background = Background.new(data[:results].first, params[:location])

    render json: BackgroundSerializer.new(background)
  end
end