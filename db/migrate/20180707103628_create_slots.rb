class CreateSlots < ActiveRecord::Migration[5.1]
  def change
    create_table :slots do |t|
      t.integer :user_id
      t.string :slot_name
      t.text :description
      t.time :start_time
      t.time :end_time
      t.integer :min_amount
      t.date :bid_start
      t.date :bid_end
      t.integer :winner_bid
      t.integer :status, :default => 1

      t.timestamps
    end
  end
end
