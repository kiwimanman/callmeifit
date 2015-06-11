class PhoneIdToNumber < ActiveRecord::Migration
  def up
    add_column :snow_events, :phone_number, :text
    remove_column :snow_events, :phone_id
  end

  def down
    drop_column :snow_events, :phone_number
    remove_column :snow_events, :phone_id, :text
  end
end
