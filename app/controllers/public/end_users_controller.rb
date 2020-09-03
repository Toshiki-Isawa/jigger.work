class Public::EndUsersController < ApplicationController
  before_action :set_user

  def show
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
  def set_user
    @user = current_end_user
  end
end
