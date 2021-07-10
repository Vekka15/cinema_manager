# frozen_string_literal: true

module Authorization
  class MissingAuthorizationTokenError < StandardError
    def initialize(message = "Please pass Bearer token to authorize correctly.")
      super(message)
    end
  end
end
