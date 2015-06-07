# == Schema Information
#
# Table name: message_confirmations
#
#  id                    :integer          not null, primary key
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :integer
#  user_type             :string
#  activity_message_id   :integer
#  activity_message_type :string
#

class MessageConfirmation < ActiveRecord::Base
  belongs_to :user, polymorphic: true
  belongs_to :activity_message, polymorphic: true
end
