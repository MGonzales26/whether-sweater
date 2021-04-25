require 'rails_helper'

RSpec.describe 'user post endpoints' do
  describe 'happy path' do
    it 'creates a user' do
      create(:user,password: '1234', password_confirmation: '1234')

      user_info = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      expect(User.last.email).to_not eq('whatever@example.com')

      post '/api/v1/users', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'},
      params: JSON.generate(user_info)

      expect(response.status).to eq(201)
      expect(User.last.email).to eq('whatever@example.com')

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Hash)
      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to be_a(String)
      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to be_a(String)
      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to be_a(Hash)
      expect(result[:data][:attributes]).to have_key(:email)
      expect(result[:data][:attributes][:email]).to be_a(String)
      expect(result[:data][:attributes]).to have_key(:api_key)
      expect(result[:data][:attributes][:api_key]).to be_a(String)
    end
  end

  describe 'sad path' do
    it 'returns a 400 error if email exists' do
      create(:user, email: 'whatever@example.com',  password: '1234', password_confirmation: '1234')

      user_info = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }


      post '/api/v1/users', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'},
      params: JSON.generate(user_info)

      expect(response.status).to eq(400)
    end

    it 'returns a 400 error if password confirmation does not match' do  
      user_info = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'word'
      }

      post '/api/v1/users', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'},
      params: JSON.generate(user_info)

      expect(response.status).to eq(400)
    end

    it 'returns a 400 error if email is empty' do  
      user_info = {
        email: '',
        password: 'password',
        password_confirmation: 'password'
      }

      post '/api/v1/users', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'},
      params: JSON.generate(user_info)

      expect(response.status).to eq(400)
    end

    it 'returns a 400 error if password is empty' do  
      user_info = {
        email: 'whatever@example.com',
        password: '',
        password_confirmation: 'password'
      }

      post '/api/v1/users', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'},
      params: JSON.generate(user_info)

      expect(response.status).to eq(400)
    end
  end
end