require 'uri'

module Oauth
  extend ActiveSupport::Concern

  private

  def github_scope!
    # oauth callback must be called with this returned
    session[:oauth_state] = SecureRandom.hex(16) 
    client_id = ENV['GITHUB_CLIENT_ID']
    # Application permission scope is only public data.
    "https://github.com/login/oauth/authorize?client_id=#{client_id}&state=#{session[:oauth_state]}"
  end
end