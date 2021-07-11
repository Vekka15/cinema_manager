# frozen_string_literal: true

module Middleware
  class Authorization < Grape::Middleware::Base
    def before
      return unless context.route_setting(:description).dig(:auth)

      env['user'] = authorized_user
    end

    private

    def authorized_user
      if decoded_token && (user = User.find_by(id: decoded_token['user_id']))
        user
      else
        raise ::Authorization::UnauthorizedError.new
      end
    end

    def authorization_header
      raise ::Authorization::MissingAuthorizationTokenError.new unless header_env

      header_env.split(' ').last
    end

    def header_env
      @header_env ||= env['HTTP_AUTHORIZATION']
    end

    def decoded_token
      @decoded_token ||= ::JsonWebToken.decode(authorization_header)
    end
  end
end
