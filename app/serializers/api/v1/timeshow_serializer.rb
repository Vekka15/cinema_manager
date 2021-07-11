# frozen_string_literal: true

module Api
  module V1
    class TimeshowSerializer < BaseSerializer
      attributes :start_time,
                 :price,
                 :movie_id,
                 :user_id
    end
  end
end
