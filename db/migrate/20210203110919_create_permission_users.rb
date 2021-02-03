class CreatePermissionUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :permission_users do |t|
      t.integer :permission_id
      t.integer :role_id

      t.timestamps
    end

    add_index :permission_users, :permission_id
    add_index :permission_users, :role_id
    add_index :permission_users, [:permission_id, :role_id]
  end
end
