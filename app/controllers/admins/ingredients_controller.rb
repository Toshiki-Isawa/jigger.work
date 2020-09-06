class Admins::IngredientsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @ingredients = Ingredient.all
  end

  def create
  end

  def destroy
  end
end
