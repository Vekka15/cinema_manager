Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount V1::Root => '/api/v1'

  mount GrapeSwaggerRails::Engine => '/swagger'
end
