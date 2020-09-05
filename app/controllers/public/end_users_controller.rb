class Public::EndUsersController < ApplicationController
  before_action :set_end_user

  def show
    @my_recipes = Cocktail.where(end_user_id: @end_user.id)
  end

  def edit
  end

  def update
    if @end_user.update(end_user_params)
      redirect_to public_end_users_path, notice: '登録情報を変更しました'
    else
      render :edit
    end
    
  end

  def unsubscribe
  end

  def withdraw
  end

  private
  def end_user_params
    params.require(:end_user).permit(:name, :email, :image)
  end

  def set_end_user
    @end_user = current_end_user
  end
end
