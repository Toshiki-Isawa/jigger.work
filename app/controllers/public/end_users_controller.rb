class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!
  before_action :set_end_user
  before_action :check_guest, only: [:update,:withdraw]

  def show
    @user = EndUser.find(params[:id])
    @recipes = Cocktail.where(end_user_id: @user.id).page(params[:page]).without_count.per(10)
    @favorite_cocktails = @user.favorite_cocktails
    @follow_users = @user.followings

    if end_user_signed_in?
      #Entry内のend_user_idがcurrent_end_userと同じEntry
      @currentUserEntry = Entry.where(end_user_id: current_end_user.id)
      #Entry内のend_user_idがMYPAGEのparams.idと同じEntry
      @userEntry = Entry.where(end_user_id: @user.id)
      #@user.idとcurrent_end_user.idが同じでなければ
      unless @user.id == current_end_user.id
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            #もしcurrent_end_user側のルームidと＠user側のルームidが同じであれば存在するルームに飛ぶ
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
    if @end_user.update(end_user_params)
      flash[:notice] = "登録情報を変更しました"
      redirect_to public_end_user_path
    else
      render :edit
    end  
  end

  def withdraw
    @end_user.update(is_active: false)
    reset_session
    flash[:notice] = "ご利用ありがとうございました。"
    redirect_to public_end_user_top_path
  end

  def check_guest
    if @end_user.email == 'guest@example.com'
      redirect_to root_path
      flash[:alert] = 'ゲストユーザーの変更・退会はできません。'
    end
  end

  private
  def end_user_params
    params.require(:end_user).permit(:name, :email, :image)
  end

  def set_end_user
    @end_user = current_end_user
  end
end
