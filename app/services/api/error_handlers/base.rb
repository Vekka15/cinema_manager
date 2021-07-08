# frozen_string_literal: true

module Api
  module ErrorHandlers
    class Base

      STATUS = 400

      def initialize(exception)
        @exception = exception
      end

      def self.respond(exception)
        new(exception).respond
      end

      def respond
        Rack::Response.new(
          options.to_json, STATUS
        )
      end

      private

      attr_accessor :exception
    end
  end
end
