class PhoneVerification < ActiveRecord::Migration
  def up
    add_column :phones, :verification_token, :string
  end

  def down
    remove_column :phones, :verification_token
  end
end
