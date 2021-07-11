class Movie < ApplicationRecord
  has_many :timeshows
  has_many :users, through: :timeshows

  validates :title, :imdb_id, presence: true
end
