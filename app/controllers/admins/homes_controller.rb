class Admins::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @cocktails = Cocktail.all
    
  end
end
