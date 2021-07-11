# frozen_string_literal: true

module Api
  class Authentication
    include Callable

    def initialize(username, password)
      @username = username
      @password = password
    end

    def call
      return ::JsonWebToken.encode(user_id: user.id) if user && user.authenticate(password)
        
      raise InvalidCredentialsError.new
    end

    private

    attr_reader :username, :password

    def user
      @user ||= User.find_by(username: username)
    end
  end
end
