# frozen_string_literal: true

module Authorization
  class UnauthorizedError < CustomError
    def initialize(message = 'You are not allowed to perform this action', status = 401)
      super(message, status)
    end
  end
end
