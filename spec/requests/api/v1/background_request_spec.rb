require 'rails_helper'

RSpec.describe 'background request' do
  describe 'happy path' do
    it 'returns an image for the given city' do
      VCR.use_cassette('background_image_denver') do

        get "/api/v1/backgrounds?location=denver,co",
        headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  
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
end