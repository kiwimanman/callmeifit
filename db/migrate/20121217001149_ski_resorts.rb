class SkiResorts < ActiveRecord::Migration
  def up
    create_table :ski_resorts do |t|
      t.text :name
      t.text :address_line1
      t.text :address_line2
      t.text :address_location
      t.text :website
      t.text :image_url
      t.text :webcam_url

      t.timestamps
    end
  end

  def down
    drop_table :ski_resorts
  end
end
