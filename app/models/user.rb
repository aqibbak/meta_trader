class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :password, :password_confirmation, :remember_me, :rights, :role_ids
  # attr_accessible :title, :body

  has_and_belongs_to_many :roles

  after_create :set_base_role

  serialize :rights, Array

  def rights_enum
    [
      [ 'Common', :common ], [ 'Backup', :backup ], [ 'Account', :account ],
      [ 'Feeder', :feeder ], [ 'Time', :time ], [ 'Group', :group ],
      [ 'Manager', :manager ], [ 'Order', :order ], [ 'Plugin', :plugin ],
      [ 'Symbol', :symbol ], [ 'Synchronization', :synchronization ], [ 'Access', :access ],
      [ 'Data Server', :data_server ], [ 'Holiday', :holiday ]
    ]
  end

  def full_rights
    all_rights = []
    roles.each do |role|
      all_rights = all_rights | role.rights
    end
    all_rights = all_rights | rights.map {|v| v.to_sym if v != ""}.compact
    return all_rights
  end

  def set_base_role
    make_regular_user
  end

  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end

  def make_admin
    self.roles << Role.admin
  end

  def revoke_admin
    self.roles.delete(Role.admin)
  end

  def admin?
    role?(:admin)
  end

  def make_regular_user
    self.roles << Role.regular_user
  end

  def revoke_regular_user
    self.roles.delete(Role.regular_user)
  end

  def regular_user?
    role?(:regular_user)
  end

  def make_power_user
    self.roles << Role.power_user
  end

  def revoke_power_user
    self.roles.delete(Role.power_user)
  end

  def power_user?
    role?(:power_user)
  end

end
