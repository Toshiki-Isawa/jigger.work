class Public::IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all
  end

  def search
    @ingredients = Ingredient.where(type_name: params[:name])
    render 'public/ingredients/index'
  end
end
