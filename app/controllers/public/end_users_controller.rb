class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!
  before_action :set_current_end_user
  before_action :check_guest, only: [:update,:withdraw]

  def show
    @end_user = EndUser.find(params[:id])
    @recipes = Cocktail.where(end_user_id: @end_user.id).order(created_at: 'DESC')
    @favorite_cocktails = @end_user.favorite_cocktails.order(created_at: 'DESC')
    @follow_users = @end_user.followings

    if end_user_signed_in?
      #Entry内のend_user_idがcurrent_end_userと同じEntry
      @currentUserEntry = Entry.where(end_user_id: current_end_user.id)
      #Entry内のend_user_idがMYPAGEのparams.idと同じEntry
      @userEntry = Entry.where(end_user_id: @end_user.id)
      #@end_user.idとcurrent_end_user.idが同じでなければ
      unless @end_user.id == current_end_user.id
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            #もしcurrent_end_user側のルームidと＠end_user側のルームidが同じであれば存在するルームに飛ぶ
            if cu.room_id == u.room_id then
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end
        #ルームが存在していなければルームとエントリーを作成する
        unless @isRoom
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  end

  def edit
  end

  def update
    if @current_end_user.update(end_user_params)
      flash[:notice] = "登録情報を変更しました"
      redirect_to public_end_user_path
    else
      render :edit
    end  
  end

  def withdraw
    @current_end_user.update(is_active: false)
    reset_session
    flash[:notice] = "ご利用ありがとうございました。"
    redirect_to public_end_user_top_path
  end

  def check_guest
    if @current_end_user.email == 'guest@example.com'
      redirect_to root_path
      flash[:alert] = 'ゲストユーザーの変更・退会はできません。'
    end
  end

  private
  def end_user_params
    params.require(:end_user).permit(:name, :email, :image)
  end

  def set_current_end_user
    @current_end_user = current_end_user
  end
end
