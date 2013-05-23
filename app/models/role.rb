class Role < ActiveRecord::Base

  has_and_belongs_to_many :users

  def self.admin
    find_or_create_by_name("admin")
  end

  def self.power_user
    find_or_create_by_name("power_user")
  end

  def self.regular_user
    find_or_create_by_name("regular_user")
  end

  def rights
    if name == "admin"
      return [:common, :backup, :account, :feeder, :time, :group, :manager, :order, :plugin, :symbol, :synchronization, :access, :data_server, :holiday ]
    elsif name == "power_user"
      return [:common, :backup, :account, :feeder, :time ]
    elsif name == "regular_user"
      return [:common]
    else
      return []
    end
  end

end
