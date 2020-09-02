class Public::CocktailsController < ApplicationController
  before_action :set_api_cocktails, only:[:index, :show]

  def index
  end

  def show
    response = open("https://cocktail-f.com/api/v1/cocktails/#{params[:id]}").read
    hash = JSON.parse(response)
    @api_cocktail = hash["cocktail"]
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
end

private

  def set_api_cocktails
    response = open("https://cocktail-f.com/api/v1/cocktails").read
    hash = JSON.parse(response)
    @api_cocktails = hash["cocktails"]
  end
