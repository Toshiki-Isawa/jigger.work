class Public::RatesController < ApplicationController
  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    rate = Rate.new(rate_params)
    rate.end_user_id = current_end_user.id
    respond_to do |format|
      rate.save
      format.js { flash.now[:notice] = 'コメントを投稿しました。' }
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:cocktail_id])
    rate = Rate.find_by(id: params[:id], cocktail_id: params[:cocktail_id])
    respond_to do |format|
      rate.destroy
      format.js { flash.now[:alert] = 'コメントを削除しました。' }
    end
  end

  private
  def rate_params
    params.require(:rate).permit(:rate,:comment,:cocktail_id,:end_user_id)
  end
end
