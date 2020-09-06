class Public::CocktailsController < ApplicationController
  before_action :authenticate_end_user!, only:[:new, :edit, :create, :update, :destroy]
  before_action :set_end_user

  def index
    @cocktails = Cocktail.all
  end

  # 材料検索用
  def search
    # 投稿カクテル
    search_ingredient = Ingredient.find_by(name: params[:name])
    @cocktails = Cocktail.includes(:ingredient_relations).where(ingredient_relations: {ingredient_id: search_ingredient.id})

    render 'public/cocktails/index'
  end

  def show
    @cocktail = Cocktail.find(params[:id])

    # カクテル名(英語)+alcohol+cocktailで画像検索 100件/1日
    # google_url = "https://www.googleapis.com/customsearch/v1?key=#{ENV['API_key']}&cx=#{ENV['Search_Engine_id']}&searchType=image&q=#{@cocktail["cocktail_name_english"]}+alcohol+cocktail&lr=lang_ja&safe=off&num=1"
    # img_response = open(google_url).read
    # hash = JSON.parse(img_response)
    # @api_cocktail_imglink = hash["items"][0]["link"]
  end

  def new
    @cocktail = Cocktail.new
    @cocktail.ingredient_relations.new
  end

  def edit
    @cocktail = Cocktail.find(params[:id])
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.end_user_id = @end_user.id

    # トップに登録された材料をベースとして@cocktailに登録
    base_id = @cocktail.ingredient_relations[0].ingredient_id
    @cocktail.base_name = Ingredient.find_by(id: base_id).name

    if @cocktail.save
      redirect_to public_end_users_path, notice: 'レシピを投稿しました'
    else
      render 'new'
    end
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    @cocktail.ingredient_relations.destroy_all

    if @cocktail.update(cocktail_params)
      redirect_to public_end_users_path, notice: 'カクテル情報を変更しました'
    else
      render :edit
    end
  end
  
  def destroy
  end
end

private

  def set_end_user
    @end_user = current_end_user
  end

  def cocktail_params
    params.require(:cocktail).permit(:name,:base_name,:technique_name,:taste_name,:style_name,:alcohol,:tpo_name,:cocktail_desc,:recipe_desc,:image,ingredient_relations_attributes:[:cocktail_id,:ingredient_id,:amount,:unit, :_destroy, ingredient_attributes:[:name, :type_name, :alcohol]])
  end
