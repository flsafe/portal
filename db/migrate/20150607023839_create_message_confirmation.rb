class CreateMessageConfirmation < ActiveRecord::Migration
  def change
    create_table :message_confirmations do |t|
      t.timestamps null: false
    end
    add_reference :message_confirmations, :user, polymorphic: true, index: {name: 'index_msg_cnfrm_user'}
    add_reference :message_confirmations, :activity_message, polymorphic: true, index: {name: 'index_msg_cnfm_activity_msg'}
  end
end
