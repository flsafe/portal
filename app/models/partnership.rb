class Partnership < ActiveRecord::Base
  belongs_to :school
  belongs_to :employer
end