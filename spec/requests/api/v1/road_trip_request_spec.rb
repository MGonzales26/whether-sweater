require 'rails_helper'

RSpec.describe 'road trip requests' do
  describe 'happy path' do
    it 'returns trip origin, destination, travel time, forecast' do
      VCR.use_cassette('road_trip_call') do
        user = create(:user, email: 'test@example.com', password: 'password', password_confirmation: 'password')

        post_body = {
          origin: "Denver,CO",
          destination: "Pueblo,CO",
          api_key: user.api_key
        }
        post '/api/v1/road_trip', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'},
        params: JSON.generate(post_body)

        expect(response).to be_successful

        road_trip = JSON.parse(response.body, symbolize_names: true)

        expect(road_trip).to be_a(Hash)
        expect(road_trip).to have_key(:data)
        expect(road_trip[:data]).to be_a(Hash)
        expect(road_trip[:data].count).to eq(3)
        expect(road_trip[:data]).to have_key(:id)
        expect(road_trip[:id]).to eq(nil)
        expect(road_trip[:data]).to have_key(:type)
        expect(road_trip[:data][:type]).to be_a(String)
        expect(road_trip[:data][:type]).to eq('roadtrip')
        expect(road_trip[:data]).to have_key(:attributes)
        expect(road_trip[:data][:attributes]).to be_a(Hash)
        expect(road_trip[:data][:attributes].count).to eq(4)
        expect(road_trip[:data][:attributes]).to have_key(:start_city)
        expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:end_city)
        expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:travel_time)
        expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
        expect(road_trip[:data][:attributes][:weather_at_eta].count).to eq(2)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
        expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
      end
    end

    it 'functions normally if the api key is present and correct' do
      VCR.use_cassette('road_trip_call') do
        user = create(:user, email: 'test@example.com', password: 'password', password_confirmation: 'password')

        post_body = {
          origin: "Denver,CO",
          destination: "Pueblo,CO",
          api_key: user.api_key
        }
        post '/api/v1/road_trip', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'},
        params: JSON.generate(post_body)

        expect(response).to be_successful

        road_trip = JSON.parse(response.body, symbolize_names: true)
      end
    end
  end

  describe 'sad path' do
    it 'returns a 401 error if the api key is missing' do
      VCR.use_cassette('road_trip_call_no_api') do
        user = create(:user, email: 'test@example.com', password: 'password', password_confirmation: 'password')

        post_body = {
          origin: "Denver,CO",
          destination: "Pueblo,CO"
        }
        post '/api/v1/road_trip', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'},
        params: JSON.generate(post_body)

        expect(response.status).to eq(401)
      end
    end

    it 'returns a 401 error if the api key is invalid' do
      VCR.use_cassette('road_trip_call_no_api') do
        user = create(:user, email: 'test@example.com', password: 'password', password_confirmation: 'password')

        post_body = {
          origin: "Denver,CO",
          destination: "Pueblo,CO",
          api_key: "LK2dfg54341hdgfp35jkgdf"
        }
        post '/api/v1/road_trip', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'},
        params: JSON.generate(post_body)

        expect(response.status).to eq(401)
      end
    end
  end
end