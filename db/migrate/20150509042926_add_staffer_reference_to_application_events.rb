class AddStafferReferenceToApplicationEvents < ActiveRecord::Migration
  def change
    add_reference :application_events, :staffer, index: true
  end
end
