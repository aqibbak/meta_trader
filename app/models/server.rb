class Server < ActiveRecord::Base

  attr_accessible :server_address

  has_and_belongs_to_many :users

  def name
    self.server_address
  end

end
