class DirectMessage < ApplicationRecord
  belongs_to :end_user
  belongs_to :room
  has_many :notifications, dependent: :destroy

  after_create_commit { DirectMessageBroadcastJob.perform_later self }

  def self.new_message_count(current_end_user)
    # ログインユーザーがエントリーしているルームIDを取得
    current_end_user_room_id = Entry.where(end_user_id: current_end_user.id).select(:room_id)
    # ログインユーザーに届いたメッセージを取得
    receive_message = DirectMessage.where(room_id: current_end_user_room_id).where.not(end_user_id: current_end_user.id)
    # 届いたメッセージの内未読の件数を取得
    count = 0
    receive_message.each do |message|
      if message.created_at > message.room.entries.where(end_user_id: current_end_user.id)[0].last_entry_at
        count += 1
      end
    end
    return count
  end

  def self.create_notification_dm(data)
    receive_user_id = Entry.where(room_id: data[:chat_room_id]).where.not(end_user_id: data[:end_user_id]).select(:end_user_id)[0][:end_user_id]
    message_id = DirectMessage.order(created_at: 'DESC').first.id
    notification = EndUser.find_by(id: data[:end_user_id]).active_notifications.new(
      visiter_id: data[:end_user_id],
      visited_id: receive_user_id,
      chat_room_id: data[:chat_room_id],
      direct_message_id: message_id,
      action: "dm"
    )
    notification.save if notification.valid?
  end

end
