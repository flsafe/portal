require 'exceptions'

class OauthController < ApplicationController

  def callback_github
    raise Exceptions::OauthStateDidNotMatch("#{params[:state]} != #{session[:oauth_state]}") unless params[:state] == session[:oauth_state]

    result = RestClient::Request.execute(method: 'POST',
                                url: 'https://github.com/login/oauth/access_token',
                                payload: {:client_id => ENV['GITHUB_CLIENT_ID'],
                                          :client_secret => ENV['GITHUB_CLIENT_SECRET'],
                                          :code => params[:code]},
                                headers: {accept: 'application/json'},
                                ssl_version: 'SSLv23')
    current_user.github_token = JSON.parse(result)['access_token']
    current_user.save!(validate: false)
    redirect_to edit_student_profile_url 
  end

  def unlink
    redirect_to edit_student_profile_url unless %w[github].include?(params[:account])

    attr_name = "#{params[:account]}_token="
    current_user.send(attr_name, nil)
    current_user.save!(validate: false)

    redirect_to edit_student_profile_url, flash: {success: 'You account has been unlinked.'}
  end

end