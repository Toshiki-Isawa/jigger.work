class Admins::CocktailsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_cocktail, only:[:show, :edit, :update, :destroy]

  def index
    @cocktails = Cocktail.all
  end
  
  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
    destroy_name = @cocktail.name
    if @cocktail.destroy
      flash[:notice] = "#{destroy_name}を削除しました"
      redirect_to admins_cocktails_path
    end
  end

  def get_api_cocktails
    # cocktail-fのカクテル一覧(1ページ目)を取得
    response = open("https://cocktail-f.com/api/v1/cocktails").read
    hash = JSON.parse(response)

    total_page = hash["total_pages"]
    page = 1
    save_count = 0
    total_page.times do
      response = open("https://cocktail-f.com/api/v1/cocktails?page=#{page}").read
      hash = JSON.parse(response)
      api_cocktails = hash["cocktails"]
      
      api_cocktails.each do |api_cocktail|
        if Cocktail.find_by(name: api_cocktail["cocktail_name"]).nil?
          cocktail = Cocktail.new
          cocktail.name = api_cocktail["cocktail_name"]
          cocktail.base_name = api_cocktail["base_name"]
          cocktail.technique_name = api_cocktail["technique_name"]
          cocktail.taste_name = api_cocktail["taste_name"]
          cocktail.style_name = api_cocktail["style_name"]
          cocktail.alcohol = api_cocktail["alcohol"]
          cocktail.tpo_name = api_cocktail["top_name"]
          cocktail.cocktail_desc = api_cocktail["cocktail_digest"]
          cocktail.recipe_desc = api_cocktail["recipe_desc"]
          cocktail.end_user_id = 1 # user1が投稿したものとする
          if cocktail.save
            save_count += 1
            api_cocktail["recipes"].each do |api_recipe|
              recipe = cocktail.ingredient_relations.new
              recipe.cocktail_id = cocktail.id
              recipe.ingredient_id = api_recipe["ingredient_id"]
              recipe.amount = api_recipe["amount"]
              recipe.unit = api_recipe["unit"]
              recipe.save
            end
          end
        end
      end
      page += 1
      if save_count > 99 then
        break
      end
    end
    flash[:notice] = "#{save_count}件のカクテルを取得しました。"
    redirect_to admins_top_path
  end

  def get_cocktail_image
    cocktails = Cocktail.all
    count = 0
    cocktails.each do |cocktail|
      if cocktail.image_id.nil?
        # カクテル名+カクテルで画像検索 100件/1日
        # google_url = URI.encode("https://www.googleapis.com/customsearch/v1?key=#{ENV['API_key']}&cx=#{ENV['Search_Engine_id']}&searchType=image&q=#{cocktail.name}+カクテル+&lr=lang_ja&safe=off&num=1")
        # img_response = open(google_url).read
        # hash = JSON.parse(img_response)
        # cocktail_imglink = hash["items"][0]["link"]
        cocktail_imglink = "https://source.unsplash.com/featured/?cocktail/#{rand(cocktails.size)}"
        cocktail.image_id = cocktail_imglink
        cocktail.save
        count += 1
      end
      # if count > 49 then
      #   break
      # end
    end
    flash[:notice] = "#{count}件の画像を取得しました。"
    redirect_to admins_cocktails_path
  end

  def search
    search_ingredient = Ingredient.find_by(name: params[:name])
    @cocktails = Cocktail.includes(:ingredient_relations).where(ingredient_relations: {ingredient_id: search_ingredient.id})

    render 'admins/cocktails/index'
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

end
