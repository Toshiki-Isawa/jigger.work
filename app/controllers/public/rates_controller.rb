class Public::RatesController < ApplicationController
  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    rate = Rate.new(rate_params)
    rate.end_user_id = current_end_user.id
    if rate.save
      flash.now[:notice] = "コメントを投稿しました。"
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render 'public/cocktail/show'
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:cocktail_id])
    rate = Rate.find_by(id: params[:id], cocktail_id: params[:cocktail_id])
    rate.destroy
    flash.now[:alert] = "コメントを削除しました。"
  end

  private
  def rate_params
    params.require(:rate).permit(:rate,:comment,:cocktail_id,:end_user_id)
  end
end
