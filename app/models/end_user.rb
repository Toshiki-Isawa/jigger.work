class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :image

  has_many :cocktails

  def active_for_authentication?
    self.is_active == true
  end

  def inactive_message
    "このアカウントは退会されています"
  end
end
