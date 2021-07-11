class Timeshow < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :price, :start_time, :movie_id, :user_id, presence: true
end
