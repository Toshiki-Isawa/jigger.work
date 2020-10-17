class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2 twitter]
  attachment :image

  has_many :cocktails
  has_many :favorites
  has_many :favorite_cocktails, through: :favorites, source: :cocktail
  has_many :rates, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  has_many :sns_credentials, dependent: :destroy
  has_many :entries
  has_many :direct_messages
  has_many :rooms, through: :entries

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

  def self.without_sns_data(auth)
    end_user = EndUser.where(email: auth.info.email).first

      if end_user.present?
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          end_user_id: end_user.id
        )
      else
        end_user = EndUser.create(
          name: auth.info.name,
          email: auth.info.email,
          birth_date: '1991-11-05',
          password: Devise.friendly_token[0, 20]
        )
        sns = SnsCredential.new(
          uid: auth.uid,
          provider: auth.provider
        )
      end
      return { end_user: end_user ,sns: sns}
    end

   def self.with_sns_data(auth, snscredential)
    end_user = EndUser.where(id: snscredential.end_user_id).first
    unless end_user.present?
      end_user = EndUser.create(
        name: auth.info.name,
        email: auth.info.email,
        birth_date: '1991-11-05',
        password: Devise.friendly_token[0, 20]
      )
    end
    return {end_user: end_user}
   end

   def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      end_user = with_sns_data(auth, snscredential)[:end_user]
      sns = snscredential
    else
      end_user = without_sns_data(auth)[:end_user]
      sns = without_sns_data(auth)[:sns]
    end
    return { end_user: end_user ,sns: sns}
  end
end
