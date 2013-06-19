class RemoveLoginAndServerFromUsers < ActiveRecord::Migration
  def up
    remove_index :users, [:login, :server_id]
    remove_column :users, :login
    remove_column :users, :server_id
  end

  def down
    add_column :users, :login, :integer, :default => 0, :null => false
    add_column :users, :server_id, :integer

    add_index :users, [:login, :server_id], :unique => true
  end
end
