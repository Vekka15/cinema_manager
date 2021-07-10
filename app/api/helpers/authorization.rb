# frozen_string_literal: true

module Helpers
  module Authorization
    def authenticate_user
      description = route_setting(:description) || route_setting(:description, {})
      description[:auth] = true
    end

    grape_api = defined?(Grape::API::Instance) ? Grape::API::Instance : Grape::API
    grape_api.extend self
  end
end
