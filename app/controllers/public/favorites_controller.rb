class Public::FavoritesController < ApplicationController

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    favorite = current_end_user.favorites.new(cocktail_id: @cocktail.id)
    favorite.save

    # Notification
    @cocktail.create_notification_by(current_end_user)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:cocktail_id])
    favorite = current_end_user.favorites.find_by(cocktail_id: @cocktail.id)
    favorite.destroy
  end
  
end
