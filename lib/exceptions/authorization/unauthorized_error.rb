# frozen_string_literal: true

module Authorization
  class UnauthorizedError < StandardError
    attr_reader :status

    def initialize(message = "You are not allowed to perform this action", status: 401)
      @status = status
      super(message)
    end
  end
end
