# frozen_string_literal: true

module Api
  module V1
    class TimeshowSerializer < BaseSerializer
      attributes :movie_id,
                 :start_time,
                 :price

      belongs_to :user
    end
  end
end
