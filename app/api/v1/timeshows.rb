# frozen_string_literal: true

module V1
  class Timeshows < V1::Base
    use_api

    resource :timeshows do
      desc 'Create new timeshow',
            success: { code: 201, model: Api::V1::TimeshowSerializer, message: 'Timeshow created' }

      authenticate_user

      params do
        requires :timeshow, type: Hash do
          requires :movie_id, type: Integer, desc: 'Id of movie connected with time show'
          requires :start_time, type: DateTime, desc: 'Time when time shows starts'
          requires :price, type: Integer, desc: 'Price of the time show'
        end
      end

      post '/' do
        timeshow = ::Timeshows::Create.call(
          user: current_user, params: declared(params)
        )

        render_serialized timeshow
      end

      desc 'Updates timeshow',
            success: { code: 204, model: Api::V1::TimeshowSerializer, message: 'Timeshow updated' }

      authenticate_user

      params do
        optional :timeshow, type: Hash do
          optional :start_time, type: DateTime, desc: 'Time when time shows starts'
          optional :price, type: Integer, desc: 'Price of the time show'
        end
      end

      patch '/:id' do
        timeshow = ::Timeshows::Update.call(
          id: params[:id], user: current_user, params: declared(params, include_missing: false)
        )

        render_serialized timeshow
      end

      desc 'Destroys timeshow',
            success: { code: 204, message: 'Timeshow destroyed' }

      authenticate_user

      delete '/:id' do
        ::Timeshows::Destroy.call(id: params[:id], user: current_user)

        body false
      end
    end
  end
end
