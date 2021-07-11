module Api
  module V1
    class BaseSerializer
      include JSONAPI::Serializer

      def self.context_attributes(*attrs, **opts)
        attrs.each do |attr|
          attribute(attr, **opts) do |record, context|
            context[attr.to_s.camelize.capitalize]
          end
        end
      end
    end
  end
end