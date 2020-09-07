class Public::EndUsersController < ApplicationController
  before_action :set_end_user

  def show
    @my_recipes = Cocktail.where(end_user_id: @end_user.id)
    @favorite_cocktails = @end_user.favorite_cocktails
  end

  def edit
  end

  def update
    if @end_user.update(end_user_params)
      flash[:notice] = "登録情報を変更しました"
      redirect_to public_end_users_path
    else
      render :edit
    end  
  end


  def withdraw
    @end_user.update(is_active: false)
    reset_session
    flash[:notice] = "ご利用ありがとうございました。"
    redirect_to public_end_user_top_path
  end

  private
  def end_user_params
    params.require(:end_user).permit(:name, :email, :image)
  end

  def set_end_user
    @end_user = current_end_user
  end
end
