class AddUserPhones < ActiveRecord::Migration
  def up
    create_table :phones do |t|
      t.references :user
      t.string     :international
      t.string     :number
      t.string     :extension
      t.boolean    :verified

      t.timestamps
    end
  end

  def down
    drop_table :phones
  end
end
