# frozen_string_literal: true

module V1
  class Users < V1::Base
    use_api

    resources :users do
      desc 'Login cinema owner',
            success: { code: 201, message: '' }

      params do
        requires :username, type: String, desc: 'Email of a user'
        requires :password, type: String, desc: 'Password of a user'
      end

      post '/sign_in' do
      end
    end
  end
end
