# frozen_string_literal: true

module V1
  class Movies < V1::Base
    use_api

    helpers do
      def user
        User.find(params[:owner_id])
      end

      def movie
        @movie ||= begin
          scope = params[:owner_id] ? user.movies : Movie.all
          scope.find(params[:id])
        end
      end
    end

    namespace 'movies/:id' do
      resources :timeshows do
        desc 'List all timeshows',
             success: { code: 200, model: Api::V1::TimeshowSerializer, message: 'Timeshows listed' }

        params do
          optional :owner_id, type: Integer, desc: 'Id of movie owner'
        end

        get '/' do
          timeshows = ::Timeshows::Retrieve.call(movie: movie)

          render_serialized timeshows
        end
      end

      desc 'Fetch movie details',
            success: { code: 200, model: Api::V1::MovieSerializer, message: 'Timeshows listed' }

      get '/details' do
        open_movie = ::OpenMovieFetcher.call(movie: movie)

        render_serialized movie, context: open_movie
      end
    end
  end
end
