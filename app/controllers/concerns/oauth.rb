module Oauth
  extend ActiveSupport::Concern

  private

  def github_scope!
    # oauth callback must be called with this returned
    session[:oauth_state] = SecureRandom.hex(16) 
    client_id = ENV['GITHUB_CLIENT_ID']
    # We don't provide the scope parameter so this is read only public info
    "https://github.com/login/oauth/authorize?client_id=#{client_id}&state=#{session[:oauth_state]}"
  end
end