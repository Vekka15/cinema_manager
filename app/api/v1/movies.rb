# frozen_string_literal: true

module V1
  class Movies < V1::Base
    use_api

    namespace 'movies/:id' do
      resources :timeshows do
        desc 'List all timeshows',
             success: { code: 200, model: Api::V1::TimeshowSerializer, message: 'Timeshows listed' }

        params do
          optional :owner_id, type: Integer, desc: 'Id of movie owner'
        end

        get '/' do
          timeshows = ::Timeshows::Retrieve.call(movie_id: params[:id], user_id: params[:owner_id])

          render_serialized timeshows
        end
      end
    end
  end
end
