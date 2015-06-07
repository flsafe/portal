class MessageConfirmationsController < ApplicationController
  def toggle_confirmation
    @activity_message = ActivityMessage.find(params[:activity_message_id])
    if @confirmation = MessageConfirmation.find_by(user: current_user, activity_message: @activity_message)
      @confirmation.destroy!
      @confirmation = nil
    else
      @confirmation = MessageConfirmation.create!(user: current_user, activity_message: @activity_message)
    end
    respond_to do |format|
      format.js
    end
  end
end