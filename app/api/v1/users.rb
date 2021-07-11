# frozen_string_literal: true

module V1
  class Users < V1::Base
    use_api

    resources :users do
      desc 'Login cinema owner',
            success: { code: 200, message: '' }

      params do
        requires :username, type: String, desc: 'Email of a user'
        requires :password, type: String, desc: 'Password of a user'
      end

      post '/sign_in' do
        token = ::Api::Authentication.call(params[:username], params[:password])

        render({ token: token })
      end    
    end
  end
end
