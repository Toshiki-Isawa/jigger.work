class Public::RelationshipsController < ApplicationController

  def create
    @end_user = EndUser.find(params[:end_user_id])
    follow = current_end_user.active_relationships.new(follower_id: params[:end_user_id])
    follow.save
    @end_user.create_notification_follow!(current_end_user)
  end

  def destroy
    @end_user = EndUser.find(params[:end_user_id])
    follow = current_end_user.active_relationships.find_by(follower_id: params[:end_user_id])
    follow.destroy
  end
end
