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

      post '/api/v1/users', headers: { 'Content-Type' => 'application/'},
      params: JSON.generate(user_info)

      expect(response.status).to eq(201)
      expect(User.last.email).to eq('whatever@example.com')
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
  
  
        post '/api/v1/users', headers: { 'Content-Type' => 'application/'},
        params: JSON.generate(user_info)
  
        expect(response.status).to eq(400)
    end

    it 'returns a 400 error if password confirmation does not match' do  
        user_info = {
          email: 'whatever@example.com',
          password: 'password',
          password_confirmation: 'word'
        }
  
        post '/api/v1/users', headers: { 'Content-Type' => 'application/'},
        params: JSON.generate(user_info)
  
        expect(response.status).to eq(400)
    end

    it 'returns a 400 error if email is empty' do  
        user_info = {
          email: '',
          password: 'password',
          password_confirmation: 'password'
        }
  
        post '/api/v1/users', headers: { 'Content-Type' => 'application/'},
        params: JSON.generate(user_info)
  
        expect(response.status).to eq(400)
    end

    it 'returns a 400 error if password is empty' do  
        user_info = {
          email: 'whatever@example.com',
          password: '',
          password_confirmation: 'password'
        }
  
        post '/api/v1/users', headers: { 'Content-Type' => 'application/'},
        params: JSON.generate(user_info)
  
        expect(response.status).to eq(400)
    end
  end
end