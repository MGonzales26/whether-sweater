require 'rails_helper'

RSpec.describe 'forecast request' do
  describe 'happy path' do
    it 'returns the forcast for a given city' do
      VCR.use_cassette('mapquest_location_denver') do

        get "/api/v1/forecast?location=denver,co", 
        headers: {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
  
        expect(response.status).to eq(200)
  
        result = JSON.parse(response.body, symbolize_names: true)
        
        expect(result).to be_a(Hash)
        expect(result).to have_key(:data)
        expect(result[:data]).to be_a(Hash)
        expect(result[:data].count).to eq(3)
        expect(result[:data]).to have_key(:id)
        expect(result[:data][:id]).to be(nil)
        expect(result[:data]).to have_key(:type)
        expect(result[:data][:type]).to eq("forecast")
        expect(result[:data]).to have_key(:attributes)
        expect(result[:data][:attributes]).to be_a(Hash)
        expect(result[:data][:attributes].count).to eq(3)
  
        expect(result[:data][:attributes]).to have_key(:current_weather)
        expect(result[:data][:attributes][:current_weather]).to be_a(Hash)
        expect(result[:data][:attributes][:current_weather].count).to eq(10)
        expect(result[:data][:attributes][:current_weather]).to have_key(:datetime)
        expect(result[:data][:attributes][:current_weather][:datetime]).to be_a(String)
        expect(result[:data][:attributes][:current_weather]).to have_key(:sunrise)
        expect(result[:data][:attributes][:current_weather][:sunrise]).to be_a(String)
        expect(result[:data][:attributes][:current_weather]).to have_key(:sunset)
        expect(result[:data][:attributes][:current_weather][:sunset]).to be_a(String)
        expect(result[:data][:attributes][:current_weather]).to have_key(:temperature)
        expect(result[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
        # Temperature in Fahrenheit
        expect(result[:data][:attributes][:current_weather]).to have_key(:feels_like)
        expect(result[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
        # Temperature in Fahrenheit
        expect(result[:data][:attributes][:current_weather]).to have_key(:humidity)
        expect(result[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)
        expect(result[:data][:attributes][:current_weather]).to have_key(:uvi)
        expect(result[:data][:attributes][:current_weather][:uvi]).to be_a(Float)
        expect(result[:data][:attributes][:current_weather]).to have_key(:visibility)
        expect(result[:data][:attributes][:current_weather][:visibility]).to be_a(Integer)
        expect(result[:data][:attributes][:current_weather]).to have_key(:conditions)
        expect(result[:data][:attributes][:current_weather][:conditions]).to be_a(String)
        expect(result[:data][:attributes][:current_weather]).to have_key(:icon)
        expect(result[:data][:attributes][:current_weather][:icon]).to be_a(String)
        
        # daily_weather an array of the next 5 days of daily weather data
        expect(result[:data][:attributes]).to have_key(:daily_weather)
        expect(result[:data][:attributes][:daily_weather]).to be_an(Array)
        expect(result[:data][:attributes][:daily_weather].count).to eq(5)
        expect(result[:data][:attributes][:daily_weather].first).to be_a(Hash)
        expect(result[:data][:attributes][:daily_weather].first.count).to eq(7)
        expect(result[:data][:attributes][:daily_weather].first).to have_key(:date)
        expect(result[:data][:attributes][:daily_weather].first[:date]).to be_a(String)
        expect(result[:data][:attributes][:daily_weather].first).to have_key(:sunrise)
        expect(result[:data][:attributes][:daily_weather].first[:sunrise]).to be_a(String)
        expect(result[:data][:attributes][:daily_weather].first).to have_key(:sunset)
        expect(result[:data][:attributes][:daily_weather].first[:sunset]).to be_a(String)
        expect(result[:data][:attributes][:daily_weather].first).to have_key(:max_temp)
        expect(result[:data][:attributes][:daily_weather].first[:max_temp]).to be_a(Float)
        expect(result[:data][:attributes][:daily_weather].first).to have_key(:min_temp)
        expect(result[:data][:attributes][:daily_weather].first[:min_temp]).to be_a(Float)
        expect(result[:data][:attributes][:daily_weather].first).to have_key(:conditions)
        expect(result[:data][:attributes][:daily_weather].first[:conditions]).to be_a(String)
        expect(result[:data][:attributes][:daily_weather].first).to have_key(:icon)
        expect(result[:data][:attributes][:daily_weather].first[:icon]).to be_a(String)
        
        # hourly_weather an array of the next 8 hours of hourly weather data
        expect(result[:data][:attributes]).to have_key(:hourly_weather)
        expect(result[:data][:attributes][:hourly_weather]).to be_an(Array)
        expect(result[:data][:attributes][:hourly_weather].count).to eq(8)
        expect(result[:data][:attributes][:hourly_weather].first).to be_a(Hash)
        expect(result[:data][:attributes][:hourly_weather].first.count).to eq(4)
        expect(result[:data][:attributes][:hourly_weather].first).to have_key(:time)
        expect(result[:data][:attributes][:hourly_weather].first[:time]).to be_a(String)
        expect(result[:data][:attributes][:hourly_weather].first).to have_key(:temperature)
        expect(result[:data][:attributes][:hourly_weather].first[:temperature]).to be_a(Float)
        expect(result[:data][:attributes][:hourly_weather].first).to have_key(:conditions)
        expect(result[:data][:attributes][:hourly_weather].first[:conditions]).to be_a(String)
        expect(result[:data][:attributes][:hourly_weather].first).to have_key(:icon)
        expect(result[:data][:attributes][:hourly_weather].first[:icon]).to be_a(String)
      end
    end
  end

  describe 'sad path' do
    it 'returns an error if the location is missing' do
      VCR.use_cassette('mapquest_location_denver_sad_path_blank') do
        get "/api/v1/forecast", 
        headers: {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
  
        expect(response.status).to eq(400)
      end
    end

    it 'returns no content status if the location is jibberish' do
      VCR.use_cassette('mapquest_location_denver_sad_path_jibberish') do
        get "/api/v1/forecast?location=klsdgjhldfjgl", 
        headers: {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

        expect(response.status).to eq(204)
      end
    end

    it 'returns no content status if the location is jibberish+nubmers' do
      VCR.use_cassette('mapquest_location_denver_sad_path_jibberish_numbers') do
        get "/api/v1/forecast?location=klsdgjhldfjgl24645", 
        headers: {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

        expect(response.status).to eq(204)
      end
    end
  end
end