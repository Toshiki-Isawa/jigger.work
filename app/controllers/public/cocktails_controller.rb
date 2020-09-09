class Public::CocktailsController < ApplicationController
  before_action :authenticate_end_user!, only:[:new, :edit, :create, :update, :destroy]
  before_action :set_end_user
  before_action :set_cocktail, only:[:show, :edit, :update, :destroy]

  def index
    @cocktails = Cocktail.all
  end

  def search
    # サイドバー検索
    if params[:search_key] == "base"
      @cocktails = Cocktail.where(base_name: params[:name])
      @page_title = "#{params[:name]}ベースの"
    elsif params[:search_key] == "technique"
      @cocktails = Cocktail.where(technique_name: params[:name])
      @page_title = "#{params[:name]}"
    elsif params[:search_key] == "taste"
      @cocktails = Cocktail.where(taste_name: params[:name])
      @page_title = "#{params[:name]}な味わいの"
    elsif params[:search_key] == "style"
      @cocktails = Cocktail.where(style_name: params[:name])
      @page_title = "#{params[:name]}スタイル"
    elsif params[:search_key] == "tpo"
      @cocktails = Cocktail.where(tpo_name: params[:name])
      @page_title = "#{params[:name]}の"
      
    # 材料検索
    elsif params[:search_key] == "ingredient" 
      search_ingredient = Ingredient.find_by(name: params[:name])
      @cocktails = Cocktail.includes(:ingredient_relations).where(ingredient_relations: {ingredient_id: search_ingredient.id})
      @page_title = "#{params[:name]}を使った"
    end
    
    render 'public/cocktails/index'
  end

  def show
    similar_table = Similar.where(cocktail1: @cocktail.id).or(Similar.where(cocktail2: @cocktail.id)).order("value DESC").limit(3).pluck(:cocktail1,:cocktail2)
    @similar_cocktails = []
    similar_table.each do |ids|
      ids.each do |id|
        unless id == @cocktail.id
          similar_cocktail = Cocktail.find(id)
          @similar_cocktails.push(similar_cocktail)
        end
      end
    end
  end

  def new
    @cocktail = Cocktail.new
    @cocktail.ingredient_relations.new
  end

  def edit
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.end_user_id = @end_user.id

    # トップに登録された材料をベースとして@cocktailに登録
    base_id = @cocktail.ingredient_relations[0].ingredient_id
    @cocktail.base_name = Ingredient.find_by(id: base_id).name

    if @cocktail.save
      flash[:notice] = "レシピを投稿しました"
      redirect_to public_end_users_path
    else
      render 'new'
    end
  end

  def update
    @cocktail.ingredient_relations.destroy_all
    if @cocktail.update(cocktail_params)
      flash[:notice] = "カクテル情報を変更しました"
      redirect_to public_end_users_path
    else
      render :edit
    end
  end
  
  def destroy
    destroy_name = @cocktail.name
    if @cocktail.destroy
      flash[:notice] = "#{destroy_name}を削除しました"
      redirect_to public_cocktails_path
    end
  end
end

private

  def set_end_user
    @end_user = current_end_user
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name,:base_name,:technique_name,:taste_name,:style_name,:alcohol,:tpo_name,:cocktail_desc,:recipe_desc,:image,ingredient_relations_attributes:[:cocktail_id,:ingredient_id,:amount,:unit, :_destroy, ingredient_attributes:[:name, :type_name, :alcohol]])
  end
