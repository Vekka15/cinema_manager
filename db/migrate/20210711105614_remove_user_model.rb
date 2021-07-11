class RemoveUserModel < ActiveRecord::Migration[6.0]
  def change
    remove_reference :timeshows, :user_movie, index: true, foreign_key: true
    drop_table :user_movies
    add_reference :timeshows, :user, index: true
    add_reference :timeshows, :movie, index: true
  end
end
