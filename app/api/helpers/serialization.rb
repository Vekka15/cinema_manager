# frozen_string_literal: true

module Helpers
  module Serialization
    def render_serialized(object, serializer: nil, context: {})
      serializer ||= serializer_for(object).constantize

      render(
        serializer.new(object, params: context).serializable_hash.to_json
      )
    end

    private

    def serializer_for(object)
      if object.respond_to?(:model_name)
        "Api::V1::#{object.model_name.name}Serializer"
      else
        "Api::V1::#{object.class}Serializer"
      end
    end
  end
end
