require 'rails_helper'

describe Api::Authentication do
  subject(:authenticator) { Api::Authentication.call(username, password) }

  let(:username) { 'test_user' }
  let(:password) { 'test_password' }
  let(:user) do
    create :user, username: 'test_user', password_digest: BCrypt::Password.create('test_password')
  end

  context 'with correct credentials' do
    it 'returns token' do
      expect(authenticator).not_to be_nil
    end
  end

  context 'with incorrect credentials' do
    shared_examples 'invalid_credentials' do
      it 'raises error' do
        expect { authenticator }.to raise_error(::InvalidCredentialsError)
      end
    end

    context 'with incorrect username' do
      let(:username) { 'incorrect_username' }

      it_behaves_like 'invalid_credentials'
    end

    context 'with incorrect password' do
      let(:password) { 'incorrect_password' }

      it_behaves_like 'invalid_credentials'
    end
  end
end