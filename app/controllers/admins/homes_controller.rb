class Admins::HomesController < ApplicationController
  def top
    @cocktails = Cocktail.all
    
  end
end
