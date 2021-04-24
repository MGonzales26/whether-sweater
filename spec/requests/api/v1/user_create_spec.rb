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
end