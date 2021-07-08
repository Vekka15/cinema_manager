# frozen_string_literal: true

module Api
  module ErrorHandlers
    class GrapeValidation < Base

      STATUS = 422

      private

      def options
        {
          errors: fields_errors
        }
      end

      def fields_errors
        [].tap do |errors|
          exception.errors.each do |error_key, field_exceptions|
            field = error_key.first || 'base'

            field_exceptions.each do |field_exception|
              errors << {
                field: field,
                message: field_exception.message
              }
            end
          end
        end
      end
    end
  end
end
