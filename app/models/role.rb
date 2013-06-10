class Role < ActiveRecord::Base
  RIGHTS = [
      [ 'Common', :common ], [ 'Common - name', :common_name ], [ 'Common - address', :common_address ],
      [ 'Common - port', :common_port ], [ 'Common - demo aacounts', :common_typeofdemo ],
      [ 'Common - time of demo', :common_timeofdemo ], [ 'Common - timezone', :common_timezone ],
      [ 'Common - DST correction', :common_daylightcorrection ], [ 'Common - end of day time', :common_endhour ],
      [ 'Common - rollover mode', :common_rollovers_mode ], [ 'Common - statements mode', :common_statement_mode ],
      [ 'Common - monthly statements mode', :common_monthly_state_mode ], [ 'Common - statementws at weekend', :common_statement_weekend ],
      [ 'Common - keep internal emails', :common_keepemails ], [ 'Common - keep ticks', :common_keepticks ],
      [ 'Common - optimization time', :common_optimization_time ], [ 'Common - antiflood controls', :common_antiflood ],
      [ 'Common - antiflood max connections', :common_floodcontrol ], [ 'Common - feeder switch timeout', :common_feeder_timeout ],
      [ 'Common - live update mode', :common_liveupdate_mode ], [ 'Common - time synchronization', :common_timesync ],
      [ 'Common - IP Access list', :common_web_adresses ], [ 'Common - path to orders/accounts bases', :common_path_database ],
      [ 'Common - path to history bases', :common_path_history ], [ 'Common - path to log files', :common_path_log ],
      [ 'Common - adapters', :common_adapter ],

      [ 'Backup', :backup ],
      [ 'Account', :account ],
      [ 'Feeder', :feeder ],
      [ 'Time', :time ],
      [ 'Group', :group ],
      [ 'Manager', :manager ],
      [ 'Order', :order ],
      [ 'Plugin', :plugin ],
      [ 'Symbol', :symbol ],
      [ 'Synchronization', :synchronization ],
      [ 'Access', :access ],
      [ 'Data Server', :data_server ],
      [ 'Holiday', :holiday ]
    ]

  attr_accessible :name, :rights

  has_and_belongs_to_many :users

  serialize :rights, Array

  def self.admin
    find_or_create_by_name("admin")
  end

  def self.power_user
    find_or_create_by_name("power_user")
  end

  def self.regular_user
    find_or_create_by_name("regular_user")
  end

  def rights_enum
    RIGHTS
  end

  def rights_old
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
