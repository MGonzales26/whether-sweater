require 'rails_helper'

RSpec.describe 'background request' do
  before(:each) do
    @headers = { 'Content-Type' => 'application/', 'Accept' => 'application/json '}
  end
  describe 'happy path' do
    it 'returns an image for the given city' do
      VCR.use_cassette('background_image_denver') do

        get "/api/v1/backgrounds?location=denver,co",
        headers: @headers
  
        expect(response.status).to eq(200)
  
        result = JSON.parse(response.body, symbolize_names: true)
  
        expect(result).to be_a(Hash)
        expect(result).to have_key(:data)
        expect(result[:data]).to be_a(Hash)
        expect(result[:data].count).to eq(3)
        expect(result[:data]).to have_key(:type)
        expect(result[:data][:type]).to eq('image')
        expect(result[:data]).to have_key(:id)
        expect(result[:data][:id]).to eq(nil)
        expect(result[:data]).to have_key(:attributes)
        expect(result[:data][:attributes]).to be_a(Hash)
        expect(result[:data][:attributes].count).to eq(1)
        expect(result[:data][:attributes]).to have_key(:image)
        expect(result[:data][:attributes][:image]).to be_a(Hash)
        expect(result[:data][:attributes][:image].count).to eq(3)
        expect(result[:data][:attributes][:image]).to have_key(:location)
        expect(result[:data][:attributes][:image][:location]).to be_a(String)
        expect(result[:data][:attributes][:image]).to have_key(:image_url)
        expect(result[:data][:attributes][:image][:image_url]).to be_a(String)
        expect(result[:data][:attributes][:image]).to have_key(:credit)
        expect(result[:data][:attributes][:image][:credit]).to be_a(Hash)
        expect(result[:data][:attributes][:image][:credit].count).to eq(3)
        expect(result[:data][:attributes][:image][:credit]).to have_key(:source)
        expect(result[:data][:attributes][:image][:credit][:source]).to be_a(String)
        expect(result[:data][:attributes][:image][:credit]).to have_key(:author)
        expect(result[:data][:attributes][:image][:credit][:author]).to be_a(String)
        expect(result[:data][:attributes][:image][:credit]).to have_key(:authorUrl)
        expect(result[:data][:attributes][:image][:credit][:authorUrl]).to be_a(String)
      end
    end
  end

  describe 'sad path' do
    it 'returns a 400 error if the location is empty' do
      get "/api/v1/backgrounds?location=",
      headers: @headers

      expect(response.status).to eq(400)
    end

    it 'returns a 400 error if the location is jibberish' do
      VCR.use_cassette('jibberish_background') do
        get "/api/v1/backgrounds?location=sdflskhg",
        headers: @headers
  
        expect(response.status).to eq(400)
      end
    end

    it 'returns a 400 error if the location is numbers' do
      VCR.use_cassette('number_background') do
        get "/api/v1/backgrounds?location=654632168",
        headers: @headers
  
        expect(response.status).to eq(400)
      end
    end

    it 'returns a 400 error if the location is missing' do
      VCR.use_cassette('missing_background') do
        get "/api/v1/backgrounds",
        headers: @headers
  
        expect(response.status).to eq(400)
      end
    end
  end
end