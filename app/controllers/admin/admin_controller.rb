class Admin::AdminController < ApplicationController
  def index
    @schools = School.order('name').all
  end
end
