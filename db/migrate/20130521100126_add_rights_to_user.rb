class AddRightsToUser < ActiveRecord::Migration
  def change
    add_column :users, :rights, :string
  end
end
