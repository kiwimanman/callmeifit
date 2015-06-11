class AddFacebook < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.text :name
    end

    create_table :facebook_keys do |t|
      t.references :user
      t.text :uid
      t.text :info
      t.text :token
      t.datetime :expires_at
      t.text :extra

      t.timestamps
    end
  end

  def down
    drop_table :facebook_keys
    drop_table :users
  end
end
