class Admins::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @cocktails = Cocktail.all
    @pv_cocktails = Cocktail.order(impressions_count: 'DESC').limit(10)
    @favorites_cocktails = Cocktail.select('cocktails.*', 'count(favorites.id) AS favs').left_joins(:favorites).group('cocktails.id').order('favs desc').limit(10)
    rates_array = Rate.group(:cocktail_id).average(:rate).sort_by{ |_, v| v }.reverse.to_h.keys
    @rates_cocktails = Cocktail.find(rates_array).sort_by{ |o| rates_array.index(o.id)}.take(10)
  end
end
