class Movie < ApplicationRecord
  has_many :timeshows
  has_many :users, through: :timeshows
end
