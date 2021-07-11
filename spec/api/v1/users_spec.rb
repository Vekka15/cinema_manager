require 'rails_helper'

describe V1::Users, type: :request do
  let!(:user) do
    create :user, username: 'test_user', password_digest: BCrypt::Password.create('test_password')
  end
  let(:basic_path) { '/api/v1/users/sign_in' }
  let(:params) { { username: username, password: password } }

  describe 'POST /sign_in' do
    before do
      post basic_path, params: params
    end

    context 'with correct credentials' do
      let(:username) { 'test_user' }
      let(:password) { 'test_password' }

      it 'returns status' do
        expect(response).to be_successful
      end

      it 'returns token' do
        expect(parsed_body['token']).to eq jwt_token_for_user(user)
      end
    end

    context 'with incorrect credentials' do
      let(:username) { 'test_user' }
      let(:password) { 'test_incorrect' }

      it 'returns status' do
        expect(response).to be_bad_request
      end

      it 'return error' do
        expect(parsed_body['error']).to eq("Check that you've entered correct username and password")
      end
    end

    context 'with missing credentials' do
      let(:params) { {} }

      it 'returns status' do
        expect(response).to be_bad_request
      end

      it 'returns error' do
        expect(parsed_body['errors']).
          to eq(
            [
              { 'field' => 'username', 'message' => 'is missing' },
              { 'field' => 'password', 'message' => 'is missing' }
            ]
          )
      end
    end
  end
end
