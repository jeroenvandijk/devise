require 'shared_user'

class User < ActiveRecord::Base
  include Shim
  include SharedUser

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
end

class UserWithLogin < User
  include Shim
  include SharedUser

  attr_accessible :login
  
  def self.find_for_database_authentication(conditions)
    key = (conditions[:login] || '').include?('@') ? :email : :username
    where({ key => conditions[:login] }).first
  end
end
