class AddRefsToApplicationEventMessages < ActiveRecord::Migration
  def change
    add_reference :activity_messages, :application_event
    add_reference :activity_messages, :staffer
  end
end
