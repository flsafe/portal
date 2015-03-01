class Opportunity < ActiveRecord::Base
  belongs_to :company
  has_many :applications
end
