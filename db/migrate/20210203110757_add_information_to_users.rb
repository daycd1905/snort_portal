class AddInformationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :phone, :string
    add_column :users, :name, :string
  end
end
