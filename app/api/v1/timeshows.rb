# frozen_string_literal: true

module V1
  class Timeshows < V1::Base
    use_api

    resources :movies do
      resources :timeshows
        desc 'List all timeshows',
            success: { code: 200, model: TimeshowSerializer, message: 'Timeshows listed' }

        params do
          optional :owner_id, type: Integer, desc: 'Id of movie owner'
        end

        get '/' do
          timeshows = Timeshows::Retrieve.call(movie_id: params[:id], owner_id: params[:owner_id])

          render_serialized timeshows
        end
      end
    end

    resources :timeshows do
      desc 'Create new timeshow',
            success: { code: 201, model: TimeshowSerializer, message: 'Timeshow created' }

      authenticate_user

      params do
        requires :movie_id, type: Integer, desc: 'Id of movie connected with time show'
        requires :start_time, type: Datetime, desc: 'Time when time shows starts'
        requires :price, type: Integer, desc: 'Price of the time show'
      end

      post '/' do
        timeshow = Timeshow::Create.call(user: current_user, params: declared(params))

        render_serialized timeshow
      end

      desc 'Updates timeshow',
            success: { code: 204, model: TimeshowSerializer, message: 'Timeshow updated' }

      authenticate_user

      params do
        optional :movie_id, type: Integer, desc: 'Id of movie connected with time show'
        optional :start_time, type: Datetime, desc: 'Time when time shows starts'
        optional :price, type: Integer, desc: 'Price of the time show'
      end

      put '/:id' do
        timeshow = Timeshow::Update.call(
          id: params[:id], user: current_user, params: declared(params)
        )

        render_serialized timeshow
      end

      desc 'Destroys timeshow',
            success: { code: 204, message: 'Timeshow destroyed' }

      authenticate_user

      delete '/:id' do
        Timeshow::Destroy.call(id: params[:id], user: current_user)
      end
    end
  end
end
