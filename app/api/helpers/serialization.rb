# frozen_string_literal: true

module Helpers
  module Serialization
    extend ActiveSupport::Concern

    included do
      format :json
      formatter :json, Grape::Formatter::Jsonapi

      def render_serialized(object, serializer: nil)
        serializer ||= serializer_for(object)

        render(
          serializer.new(to_serialize, *serializer_args).serialized_json
        )
      end

      private

      def serializer_for(object)
        "API::V1::#{object.class}Serializer"
      end
    end
  end
end
