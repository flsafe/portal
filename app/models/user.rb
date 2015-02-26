class User < ActiveRecord::Base
  belongs_to :school
  belongs_to :company
  
  has_secure_password
  enum role: {
    admin: 1,
    student: 2,
    career_services: 3,
    instructor: 4,
    employer: 5
  }
end
