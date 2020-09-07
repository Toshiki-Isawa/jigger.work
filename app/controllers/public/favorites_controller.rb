class Public::FavoritesController < ApplicationController

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    favorite = current_end_user.favorites.new(cocktail_id: @cocktail.id)
    favorite.save
  end

  def destroy
    @cocktail = Cocktail.find(params[:cocktail_id])
    favorite = current_end_user.favorites.find_by(cocktail_id: @cocktail.id)
    favorite.destroy
  end
  
end
