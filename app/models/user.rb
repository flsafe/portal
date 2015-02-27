class User < ActiveRecord::Base
  belongs_to :school
  belongs_to :company
  
  has_secure_password
end
