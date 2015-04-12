class Admin::ApplicationController < ApplicationController
  include UserHomePage

  before_action :ensure_admin
end