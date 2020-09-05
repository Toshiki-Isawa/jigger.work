class Public::EndUsersController < ApplicationController
  before_action :set_end_user

  def show
    @my_recipes = Cocktail.where(end_user_id: @end_user.id)
  end

  def edit
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end

  private
  def set_end_user
    @end_user = current_end_user
  end
end
