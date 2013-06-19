class CreateUserServerJoinTable < ActiveRecord::Migration

  def self.up
    create_table :servers_users, :id => false do |t|
      t.references :user, :server
    end
  end

  def self.down
    drop_table :servers_users
  end

end
