class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.date :worked_on
      t.datetime :start
      t.datetime :finish
      t.references :user
      t.timestamps
    end
  end
end
