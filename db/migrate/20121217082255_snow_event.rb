class SnowEvent < ActiveRecord::Migration
  def up
    create_table :snow_events do |t|
      t.references :user
      t.references :ski_resort
      t.references :phone
      t.text :threshold

      t.timestamps
    end
  end

  def down
    drop_table :snow_events
  end
end
