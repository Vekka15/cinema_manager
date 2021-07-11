# frozen_string_literal: true

module V1
  class Base < Grape::API
    def self.use_api(settings = {})
      format :json
      formatter :json, Grape::Formatter::Jsonapi

      include ::Helpers::Authorization
      include ::Helpers::Exceptions

      helpers ::Helpers::Resources
      helpers ::Helpers::Serialization

      use ::Middleware::Authorization
    end
  end
end
