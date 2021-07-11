# frozen_string_literal: true

module Api
  module ErrorHandlers
    class RecordNotFound < Base

      private

      def options
        {
          error: message,
          trace: exception.backtrace[0, 10]
        }.compact
      end

      def status
        404
      end

      def message
        "#{status} Not Found"
      end
    end
  end
end
