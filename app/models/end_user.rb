class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :image

  has_many :cocktails
  has_many :favorites
  has_many :favorite_cocktails, through: :favorites, source: :cocktail

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  def followed_by?(end_user)
    passive_relationships.find_by(following_id: end_user.id).present?
  end

  def active_for_authentication?
    self.is_active == true
  end

  def inactive_message
    "このアカウントは退会されています"
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.name = 'Guest'
      end_user.birth_date = '1990-01-01'
    end
  end
end
