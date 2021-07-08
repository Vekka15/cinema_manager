# frozen_string_literal: true

module Api
  module ErrorHandlers
    class RecordNotFound < Base

      STATUS = 404
      MESSAGE = '404 Not Found'.freeze

      private

      def options
        {
          error: MESSAGE,
          trace: exception.backtrace[0, 10]
        }.compact
      end
    end
  end
end
