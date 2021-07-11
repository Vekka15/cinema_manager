require 'rails_helper'

describe Middleware::Authorization do
  subject(:middleware) { Middleware::Authorization.new(app).call request }

  let(:request) do
    req = Rack::MockRequest.env_for('https://content.example.com', {})
    req['HTTP_AUTHORIZATION'] = token
    req
  end
  let(:app) { ->(env) { [200, env, "app"] } }
  let(:context) { double() }

  let(:user) { create :user }

  before do
    allow_any_instance_of(Grape::Middleware::Base).to receive(:context).and_return(context)
  end

  context 'with required authorization' do
    before do
      allow(context).
        to receive(:route_setting).
           with(:description).
           and_return({ description: 'test', auth: true })
    end

    context 'with correct token' do
      let(:token) { JWT.encode({ user_id: user.id }, Rails.application.config.jwt_hmac_secret) }

      it 'authorizes user' do
        expect(middleware[1]['user']).to eq user
      end

      it 'returns success' do
        expect(middleware[0]).to eq 200
      end
    end

    context 'with incorrect token' do
      let(:token) { '111test1111' }

      it 'raises unauthorized error' do
        expect { middleware }.to raise_error(::Authorization::UnauthorizedError)
      end
    end

    context 'with missing token' do
      let(:token) { nil }

      it 'raises missing token error' do
        expect { middleware }.to raise_error(::Authorization::MissingAuthorizationTokenError)
      end
    end
  end

  context 'without required authorization' do
    let(:token) { nil }

    before do
      allow(context).
        to receive(:route_setting).
           with(:description).
           and_return({ description: 'test' })
    end

    it 'does not authorize user' do
      expect(middleware[1]['user']).to be_nil
    end

    it 'return success' do
      expect(middleware[0]).to eq 200
    end
  end
end
