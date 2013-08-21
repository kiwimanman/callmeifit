class UsersFromFacebook < ActiveRecord::Migration
  def up
    add_column  :users, :photo_url, :text
    User.all.each do |user|
      facebook_info = JSON.parse(user.facebook_keys[0].info)
      user.name = facebook_info["name"]
      user.photo_url = facebook_info["image"]
      user.save
    end
  end

  def down
    remove_column :users, :photo_url
  end
end
