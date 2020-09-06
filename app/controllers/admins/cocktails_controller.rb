class Admins::CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end
  
  def show
    @cocktail = Cocktail.find(params[:id])
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
    end
    flash[:notice] = "#{save_count}件のカクテルを取得しました。"
    redirect_to admins_top_path
  end
end
