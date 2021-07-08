# frozen_string_literal: true

module V1
  class Base < Grape::API
    def self.use_api(settings = {})
      # include API::V1::Serialization
      # include API::V1::Errors
    end
  end
end
