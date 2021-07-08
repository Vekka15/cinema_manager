module V1
  class Root < Grape::API
    mount V1::Users

    add_swagger_documentation
  end
end
