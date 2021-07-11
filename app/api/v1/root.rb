module V1
  class Root < Grape::API
    mount V1::Users
    mount V1::Timeshows

    add_swagger_documentation
  end
end
