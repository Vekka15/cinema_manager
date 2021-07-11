module V1
  class Root < Grape::API
    mount V1::Users
    mount V1::Timeshows
    mount V1::Movies

    add_swagger_documentation
  end
end
