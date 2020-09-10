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

  def withdraw
    @end_user = EndUser.find(params[:id])
    @end_user.update(is_active: false)
    flash[:notice] = "アカウントを凍結しました。"
    redirect_to admins_end_users_path
  end

  def unfreeze
    @end_user = EndUser.find(params[:id])
    @end_user.update(is_active: true)
    flash[:notice] = "アカウントを復帰しました。"
    redirect_to admins_end_users_path
  end
end
