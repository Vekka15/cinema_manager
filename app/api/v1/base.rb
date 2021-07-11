# frozen_string_literal: true

module V1
  class Base < Grape::API
    def self.use_api(settings = {})
      include ::Helpers::Authorization
      include ::Helpers::Exceptions
      include ::Helpers::Serialization
      include ::Helpers::Resources

      use ::Middleware::Authorization
    end
  end
end
