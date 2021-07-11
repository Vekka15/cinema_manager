# frozen_string_literal: true

module Authorization
  class MissingAuthorizationTokenError < CustomError
    def initialize(message = "Please pass Bearer token to authorize correctly.", status = 403)
      super(message, status)
    end
  end
end
