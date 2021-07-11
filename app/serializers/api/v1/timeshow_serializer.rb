# frozen_string_literal: true

module API
  module V1
    class TimeshowSerializer < BaseSerializer
      attributes :movie_id,
                 :owner_id,
                 :start_time,
                 :price

      belongs_to :user
    end
  end
end
