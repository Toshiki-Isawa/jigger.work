class SearchController < ApplicationController
  def search
    @cocktails = search_for(params[:content])
    if admin_signed_in?
      render 'admins/cocktails/index'
    else
      render 'public/cocktails/index'
    end
  end

  private

  def search_for(content)
    search_ingredient = Ingredient.find_by(name: content)
    if search_ingredient
      Cocktail.includes(:ingredient_relations).where(ingredient_relations: {ingredient_id: search_ingredient.id})
    else
      Cocktail.where(['name LIKE ? OR base_name LIKE ? OR cocktail_desc LIKE ? OR recipe_desc LIKE ?', "%#{content}%", "%#{content}%", "%#{content}%", "%#{content}%"])
    end
  end
end
