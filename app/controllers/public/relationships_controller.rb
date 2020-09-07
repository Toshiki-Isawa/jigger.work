class Public::RelationshipsController < ApplicationController

  def create
    follow = current_end_user.active_relationships.new(follower_id: params[:end_user_id])
    follow.save
    redirect_to public_end_user_path(current_end_user)
  end

  def destroy
    follow = current_end_user.active_relationships.find_by(follower_id: params[:end_user_id])
    follow.destroy
    redirect_to public_end_user_path(current_end_user)
  end
end
