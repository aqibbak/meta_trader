class AddRightsToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :rights, :string
  end
end

