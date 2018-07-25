class AddAllotDaysToSlots < ActiveRecord::Migration[5.1]
  def change
    add_column :slots, :allot_days, :integer
  end
end
