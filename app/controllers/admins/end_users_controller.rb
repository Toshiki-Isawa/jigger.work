class Admins::EndUsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @end_users = EndUser.all
  end

  def show
    @user = EndUser.find(params[:id])
    @recipes = Cocktail.where(end_user_id: @user.id)
    @favorite_cocktails = @user.favorite_cocktails
    @follow_users = @user.followings
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
