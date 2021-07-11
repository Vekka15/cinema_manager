class User < ApplicationRecord
  has_secure_password

  has_many :timeshows
  has_many :movies, through: :timeshows

  validates :username, presence: true
end
