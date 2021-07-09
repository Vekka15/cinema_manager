# frozen_string_literal: true

module Helpers
  module Exceptions
    extend ActiveSupport::Concern

    included do
      rescue_from Grape::Exceptions::ValidationErrors do |exception|
        ::Api::ErrorHandlers::GrapeValidation.respond(exception)
      end

      rescue_from ActiveRecord::RecordNotFound do |exception|
        ::Api::ErrorHandlers::RecordNotFound.respond(exception)
      end
    end
  end
end
