class Admins::IngredientsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @ingredients = Ingredient.all
  end

  def create
  end

  def destroy
  end

  def search
    @ingredients = Ingredient.where(type_name: params[:name])
    render 'admins/ingredients/index'
  end
end
