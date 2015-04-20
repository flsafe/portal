class InviteController < ApplicationController

  skip_before_action :authorize

  def claim
    invite = Invite.find_by!(token: params[:token])
    if User.exists?(email: invite.email)
      user = User.find_by(email: invite.email)
    else
      user = invite.invite_type.constantize.new
      user.email = invite.email
      if invite.invite_type == 'Student' 
        user.semester = invite.semester
        user.year = invite.year
        user.campus_id = invite.campus_id
        # Students have to fill in their own profile,
        # and it's enforced by the student controller. 
        user.save(validate: false)
      elsif invite.invite_type == 'Employer'
        user.company_id = invite.company_id
        user.schools << School.find(invite.school_id)
        user.save!(validate: false)
      else
        raise "Unknown user type: #{user.type}"
      end
    end
    session[:user_id] = user.id
    redirect_home user
  end

end