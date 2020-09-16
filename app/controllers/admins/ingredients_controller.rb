class Admins::IngredientsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @ingredients = Ingredient.all
    @new_ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:notice] = '材料を追加しました'
    else
      flash[:notice] = '追加に失敗しました'
    end
    redirect_to admins_ingredients_path
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update(ingredient_params)
      flash[:notice] = '材料情報を更新しました'
    end
    redirect_to admins_ingredients_path
  end

  def destroy
    ingredient = Ingredient.find(params[:id])
    destroy_name = ingredient.name
    if ingredient.destroy
      flash[:notice] = "#{destroy_name}を削除しました"
    else
      flash[:notice] = '削除に失敗しました'
    end
    redirect_to admins_ingredients_path
  end

  def search
    @ingredients = Ingredient.where(type_name: params[:name])
    @new_ingredient = Ingredient.new
    render 'admins/ingredients/index'
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name,:type_name,:alcohol)
  end

end
