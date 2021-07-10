# frozen_string_literal: true

module Api
  module ErrorHandlers
    class Base
      def initialize(exception)
        @exception = exception
      end

      def self.respond(exception)
        new(exception).respond
      end

      def respond
        Rack::Response.new(
          options.to_json, exception.try(:status) || status
        )
      end

      private

      def options
        {
          error: exception.message
        }
      end

      def status
        400
      end

      attr_accessor :exception
    end
  end
end
