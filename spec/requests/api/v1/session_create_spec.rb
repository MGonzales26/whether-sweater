require 'rails_helper'

RSpec.describe 'session creation' do
  describe 'happy path' do
    it 'creates a session' do
      user = create(:user, email: 'test@example.com', password: 'password', password_confirmation: 'password')

      login_credentials = {
        email: user.email,
        password: user.password
      }

      post '/api/v1/sessions', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
      params: JSON.generate(login_credentials)

      expect(response.status).to eq(200)
      session = JSON.parse(response.body, symbolize_names: true)

      expect(session).to be_a(Hash)
      expect(session).to have_key(:data)
      expect(session[:data]).to be_a(Hash)
      expect(session[:data].count).to eq(3)
      expect(session[:data]).to have_key(:id)
      expect(session[:data][:id]).to be_a(String)
      expect(session[:data]).to have_key(:type)
      expect(session[:data][:type]).to be_a(String)
      expect(session[:data]).to have_key(:attributes)
      expect(session[:data][:attributes]).to be_a(Hash)
      expect(session[:data][:attributes].count).to eq(2)
      expect(session[:data][:attributes]).to have_key(:email)
      expect(session[:data][:attributes][:email]).to be_a(String)
      expect(session[:data][:attributes]).to have_key(:api_key)
      expect(session[:data][:attributes][:api_key]).to be_a(String)
    end
  end

  describe 'sad path' do 
    before(:each) do
      @user = create(:user, email: 'test@example.com', password: 'password', password_confirmation: 'password')
    end
    it 'returns a 400 error if password does not pass authentication' do  
      login_credentials = {
        email: 'test@example.com',
        password: 'word'
      }

      post '/api/v1/sessions', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'},
      params: JSON.generate(login_credentials)

      expect(response.status).to eq(400)
    end

    it 'returns a 400 error if email is empty' do  
      login_credentials = {
        email: '',
        password: 'password'
      }

      post '/api/v1/sessions', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'},
      params: JSON.generate(login_credentials)

      expect(response.status).to eq(400)
    end

    it 'returns a 400 error if password is empty' do  
      login_credentials = {
        email: 'test@example.com',
        password: ''
      }

      post '/api/v1/sessions', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'},
      params: JSON.generate(login_credentials)

      expect(response.status).to eq(400)
    end
  end
end