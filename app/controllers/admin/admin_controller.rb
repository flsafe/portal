class Admin::AdminController < Admin::ApplicationController
  before_action :ensure_admin

  def index
    @schools = School.order('name').all
  end
end
