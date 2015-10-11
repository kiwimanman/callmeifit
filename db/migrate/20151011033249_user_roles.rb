class UserRoles < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE TYPE user_roles AS ENUM ('user', 'admin');
    SQL

    add_column :users, :role, :user_roles, default: 'user', null: false
  end

  def down
    remove_column :users, :role

    execute <<-SQL
      DROP TYPE user_roles;
    SQL
  end
end
