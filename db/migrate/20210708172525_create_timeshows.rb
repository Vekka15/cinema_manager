class CreateTimeshows < ActiveRecord::Migration[6.0]
  def change
    create_table :timeshows do |t|
      t.references :user_movie, null: false, foreign_key: true
      t.datetime :start_time
      t.integer :price

      t.timestamps
    end
  end
end
