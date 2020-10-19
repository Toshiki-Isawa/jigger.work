class RoomsController < ApplicationController
  before_action :authenticate_end_user!
  def index
    @user = current_end_user
    @currentEntries = current_end_user.entries
    # @currentEntriesのルームを配列にする
    myRoomIds = []
    @currentEntries.each do |entry|
      myRoomIds << entry.room.id
    end
    # @currentEntriesのルーム且つcurrent_userでないEntryを新着順で取ってくる
    @anotherEntries = Entry.where(room_id: myRoomIds).where.not(end_user_id: @user.id).order(updated_at: :desc)
  end

  def show
    @room = Room.find(params[:id])
    # ルームが作成されているかどうか
    if Entry.where(:end_user_id => current_end_user.id, :room_id => @room.id).present?
      @direct_messages = @room.direct_messages
      @entries = @room.entries
      # ルームを開いたら入室日時を記録
      Entry.where(:end_user_id => current_end_user.id, :room_id => @room.id).update(:last_entry_at => Time.now)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @room = Room.create(:name => "DM")
    # entryにログインユーザーを作成
    @entry1 = Entry.create(:room_id => @room.id, :end_user_id => current_end_user.id)
    # entryにparamsユーザーを作成
    @entry2 = Entry.create(params.require(:entry).permit(:end_user_id, :room_id).merge(:room_id => @room.id))
    # 入室日時の初期値をルームの作成日時で設定
    @entries = @room.entries.update(:last_entry_at => @room.created_at)
    redirect_to room_path(@room.id)
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to rooms_path
  end
end
