class Public::CocktailsController < ApplicationController
  before_action :authenticate_end_user!, only:[:new, :edit, :create, :update, :destroy]
  before_action :set_api_cocktails, only:[:index, :show]
  before_action :set_end_user

  def index
    @cocktails = Cocktail.all
  end

  # 材料検索用
  def search
    # API-Cocktail
    search_url = URI.encode("https://cocktail-f.com/api/v1/cocktails?word=#{params[:name]}")
    response = open(search_url).read
    hash = JSON.parse(response)
    @api_cocktails = hash["cocktails"]
    
    # 投稿カクテル
    search_ingredient = Ingredient.find_by(name: params[:name])
    @cocktails = Cocktail.includes(:ingredient_relations).where(ingredient_relations: {ingredient_id: search_ingredient.id})

    render 'public/cocktails/index'
  end

  def show
    # cocktail-fのカクテルからcocktail_idで検索
    response = open("https://cocktail-f.com/api/v1/cocktails/#{params[:id]}").read
    hash = JSON.parse(response)
    @api_cocktail = hash["cocktail"]
    @recipes = @api_cocktail["recipes"]

    # カクテル名(英語)+alcohol+cocktailで画像検索 100件/1日
    google_url = "https://www.googleapis.com/customsearch/v1?key=#{ENV['API_key']}&cx=#{ENV['Search_Engine_id']}&searchType=image&q=#{@api_cocktail["cocktail_name_english"]}+alcohol+cocktail&lr=lang_ja&safe=off&num=1"
    img_response = open(google_url).read
    hash = JSON.parse(img_response)
    @api_cocktail_imglink = hash["items"][0]["link"]
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
    @cocktail.alcohol = 10
    @cocktail.save
    if @cocktail.save
      redirect_to public_end_users_path
    else
      render 'new'
    end
  end

  def update
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

  # cocktail-fのカクテル一覧を取得
  def set_api_cocktails
    response = open("https://cocktail-f.com/api/v1/cocktails").read
    hash = JSON.parse(response)
    @api_cocktails = hash["cocktails"]
  end
