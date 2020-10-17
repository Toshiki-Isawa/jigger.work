module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_end_user

    def connect
      self.current_end_user = find_verified_user
    end

    protected
    def find_verified_user
      verified_user = EndUser.find_by(id: env['warden'].user.id)
      return reject_unauthorized_connection unless verified_user
      verified_user
    end
  end
end