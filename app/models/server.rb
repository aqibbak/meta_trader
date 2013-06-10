class Server < ActiveRecord::Base

  attr_accessible :server_address

  has_many :users

end
