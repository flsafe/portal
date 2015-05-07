# == Schema Information
#
# Table name: activity_messages
#
#  id             :integer          not null, primary key
#  type           :string
#  school_id      :integer
#  application_id :integer
#  student_id     :integer
#  employer_id    :integer
#  staff_id       :integer
#  opportunity_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class ApplicationMessage < ActivityMessage
  belongs_to :application 
  validates :application, presence: true
end
