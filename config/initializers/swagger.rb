GrapeSwaggerRails.options.url = '/api/v1/swagger_doc.json'

GrapeSwaggerRails.options.before_action do
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
end

Dir[Rails.root.join('app', 'serializers', 'api', 'v1', '**', '*.rb')].each { |f| require f }

Api::V1::BaseSerializer.descendants.each do |serializer|
  GrapeSwagger.model_parsers.register(Class.new(GrapeSwagger::Jsonapi::Parser), serializer)
end