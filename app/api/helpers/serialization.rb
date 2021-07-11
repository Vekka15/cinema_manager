# frozen_string_literal: true

module Helpers
  module Serialization
    def render_serialized(object, serializer: nil)
      serializer ||= serializer_for(object)

      render(
        serializer.new(object).serializable_hash.to_json
      )
    end

    private

    def serializer_for(object)
      "Api::V1::#{object.class}Serializer".constantize
    end
  end
end
