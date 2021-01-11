class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.datetime   :start_time, null: false
      t.datetime   :end_time,   null: false
      t.integer    :menu_id,    null: false
      t.integer    :staff_id,   null: false
      t.references :customer,   null: false, foreign_key: true
      t.timestamps
    end
  end
end
