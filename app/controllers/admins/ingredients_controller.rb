class Admins::IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all
  end

  def create
  end

  def destroy
  end
end
