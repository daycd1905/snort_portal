class CreateRoleUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :role_users do |t|
      t.integer :user_id
      t.integer :role_id

      t.timestamps
    end

    add_index :role_users, :user_id
    add_index :role_users, :role_id
    add_index :role_users, [:user_id, :role_id]
  end
end
