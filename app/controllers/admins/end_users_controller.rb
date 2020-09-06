class Admins::EndUsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @end_users = EndUser.all
  end

  def show
  end

  def edit
  end

  def update
  end
end
