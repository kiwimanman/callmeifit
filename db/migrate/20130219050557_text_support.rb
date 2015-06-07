class TextSupport < ActiveRecord::Migration
  def up
    add_column  :snow_events, :contact_by, :text
    ::SnowEvent.find(:all).load.each do |se|
      se.save
    end
  end

  def down
    remove_column  :snow_events, :contact_by
  end
end
