class AddServerToUsers < ActiveRecord::Migration
  def up
    add_column :users, :server_id, :integer

    add_index :users, [:login, :server_id], :unique => true
    remove_index :users, :login
  end

  def down
    remove_column :users, :server_id

    remove_index :users, [:login, :server_id]
    add_index :users, :login, :unique => true
  end
end
