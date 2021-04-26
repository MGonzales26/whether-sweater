require 'rails_helper'

RSpec.describe 'salaries request' do
  describe 'happy path' do
    it 'returns the tech salries and weather for a given city' do
      VCR.use_cassette('salaries_request') do
        get '/api/v1/salaries?destination=chicago'
  
        expect(response.status).to eq(200)
  
        result = JSON.parse(response.body, symbolize_names: true)
  
        expect(result).to be_a(Hash)
        expect(result.count).to eq(1)
        expect(result).to have_key(:data)
        expect(result[:data]).to be_a(Hash)
        expect(result[:data].count).to eq(3)
        expect(result[:data]).to have_key(:id)
        expect(result[:data][:id]).to eq(nil)
        expect(result[:data]).to have_key(:type)
        expect(result[:data][:type]).to eq('salaries')
        expect(result[:data]).to have_key(:attributes)
        expect(result[:data][:attributes]).to be_a(Hash)
        expect(result[:data][:attributes].count).to eq(3)
        expect(result[:data][:attributes]).to have_key(:destination)
        expect(result[:data][:attributes][:destination]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:forecast)
        expect(result[:data][:attributes][:forecast]).to be_a(Hash)
        expect(result[:data][:attributes][:forecast].count).to eq(2)
        expect(result[:data][:attributes][:forecast]).to have_key(:summary)
        expect(result[:data][:attributes][:forecast][:summary]).to be_a(String)
        expect(result[:data][:attributes][:forecast]).to have_key(:temperature)
        expect(result[:data][:attributes][:forecast][:temperature]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:salaries)
        expect(result[:data][:attributes][:salaries]).to be_a(Array)
        expect(result[:data][:attributes][:salaries].count).to eq(7)
  
        result[:data][:attributes][:salaries].each do |salary|
          expect(salary).to be_a(Hash)
          expect(salary).to have_key(:title)
          expect(salary[:title]).to be_a(String)
          expect(salary).to have_key(:min)
          expect(salary[:min]).to be_a(String)
          expect(salary).to have_key(:max)
          expect(salary[:max]).to be_a(String)
        end
      end
    end
  end


  describe 'sad path' do
    it 'returns an error if the destination is missing' do
      VCR.use_cassette('sararies_request_sad_no_loc') do
        get '/api/v1/salaries'

        expect(response.status).to eq(400)
      end
    end

    it 'returns an 204 no content error if the destination is jibberish' do
      VCR.use_cassette('sararies_sad_jibberish') do
        get '/api/v1/salaries?destination=osdijgfsdgj'

        expect(response.status).to eq(204)
      end
    end
  end
end