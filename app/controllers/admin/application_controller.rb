class Admin::ApplicationController < ApplicationController
  include UserHomePage

  before_action :ensure_admin_or_staff
end