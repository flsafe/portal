class InviteMailer < ApplicationMailer
  def send_invite(invite)
    @invite = invite
    raise ActiveRecord::RecordInvalid.new(@invite.errors.messages) if @invite.invalid?
    @school = Campus.includes(:school).where(campus_id: @invite.campus_id)
    # TODO We need to use the school custom domain
    @host = ENV['APP_HOST'] 
    mail to: @invite.email, subject: "Invite"
  end
end
