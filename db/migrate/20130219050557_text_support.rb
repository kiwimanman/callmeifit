class TextSupport < ActiveRecord::Migration
  def up
    add_column :snow_events, :contact_by, :text

    ::SnowEvent.find_each(&:save)
  end

  def down
    remove_column :snow_events, :contact_by
  end
end
