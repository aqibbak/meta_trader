class AddUsernameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :username, :string

    User.all.each do |user|
      if user.username.nil?
        if user.admin?
          user.update_attribute(:username, "admin" + user.id.to_s)
        else
          user.update_attribute(:username, "user" + user.id.to_s)
        end
      end
    end

    change_column :users, :username, :string, :null => false

    add_index :users, :username, :unique => true
  end

  def down
    remove_index :users, :username
    remove_column :users, :username
  end
end
