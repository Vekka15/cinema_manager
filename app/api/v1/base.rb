# frozen_string_literal: true

module V1
  class Base < Grape::API
    def self.use_api(settings = {})
      include ::Helpers::Exceptions
    end
  end
end
