# == Schema Information
#
# Table name: activity_messages
#
#  id                   :integer          not null, primary key
#  type                 :string
#  school_id            :integer
#  application_id       :integer
#  student_id           :integer
#  employer_id          :integer
#  staff_id             :integer
#  opportunity_id       :integer
#  created_at           :datetime
#  updated_at           :datetime
#  application_event_id :integer
#  staffer_id           :integer
#

class ApplicationEventMessage < ActivityMessage
  validates :application, :application_event, :staffer, presence: true

  before_destroy :destroy_message

  def destroy_message
    if msg = ApplicationEventMessage.find_by(application_event: self)
      msg.destroy
    end
  end
end
