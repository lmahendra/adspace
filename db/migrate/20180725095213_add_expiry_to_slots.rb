class AddExpiryToSlots < ActiveRecord::Migration[5.1]
  def change
    add_column :slots, :expiry, :date
  end
end
