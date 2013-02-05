class EventContactedAt < ActiveRecord::Migration
  def up
    add_column  :snow_events, :last_contacted, :date
  end

  def down
    remove_column  :snow_events, :last_contacted
  end
end
