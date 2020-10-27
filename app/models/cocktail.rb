class Cocktail < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :cocktail_desc, length: { maximum: 50 }
  validates :technique_name, presence: true
  validates :taste_name, presence: true
  validates :style_name, presence: true
  validates :alcohol, presence: true
  validates :tpo_name, presence: true
  validates :recipe_desc, presence: true

  enum technique_name: {
    ビルド: 1,
    ステア: 2,
    シェイク: 3,
    ブレンド: 4,
  }
  enum taste_name: {
    甘口: 1,
    中甘口: 2,
    中口: 3,
    中辛口: 4,
    辛口: 5,
  }
  enum style_name: {
    ショート: 1,
    ロング: 2,
  }
  enum tpo_name: {
    食前: 1,
    食後: 2,
    オール: 3,
  }

  belongs_to :end_user
  has_many :favorites, dependent: :destroy
  has_many :rates, dependent: :destroy
  attachment :image

  has_many :ingredient_relations, dependent: :destroy
  has_many :ingredients, through: :ingredient_relations
  accepts_nested_attributes_for :ingredient_relations, allow_destroy:true

  has_many :notifications, dependent: :destroy

  is_impressionable counter_cache: true

  # 複数条件検索
  scope :search, -> (search_params) do
    return if search_params.blank?

    keyword_like(search_params[:keyword])
      .base_like(search_params[:base_name])
      .technique_like(search_params[:technique_name])
      .taste_like(search_params[:taste_name])
      .style_like(search_params[:style_name])
      .tpo_like(search_params[:tpo_name])
      .alcohol_from(search_params[:alcohol_from])
      .alcohol_to(search_params[:alcohol_to])
  end

  scope :keyword_like, -> (keyword) { where(['name LIKE ? OR cocktail_desc LIKE ? OR recipe_desc LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"]) if keyword.present? }
  scope :base_like, -> (base) { where('base_name LIKE ?', "%#{base}%") if base.present? }
  scope :technique_like, -> (technique) { where(technique_name: technique) if technique.present? }
  scope :taste_like, -> (taste) { where(taste_name: taste) if taste.present? }
  scope :style_like, -> (style) { where(style_name: style) if style.present? }
  scope :tpo_like, -> (tpo) { where(tpo_name: tpo) if tpo.present? }
  scope :alcohol_from, -> (from) { where('? <= alcohol', from) if from.present? }
  scope :alcohol_to, -> (to) { where('alcohol <= ?', to) if to.present? }

  def favorited_by?(end_user)
    favorites.where(end_user_id: end_user.id).exists?
  end

  def create_notification_by(current_end_user)
    notification = current_end_user.active_notifications.new(
      cocktail_id: id,
      visited_id: end_user_id,
      action: "like"
    )
    notification.save if notification.valid?
  end

  def create_notification_rate!(current_end_user, rate_id)
    temp_ids = Rate.select(:end_user_id).where(cocktail_id: id).where.not(end_user_id: current_end_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_rate!(current_end_user, rate_id, temp_id['end_user_id'])
    end
    save_notification_rate!(current_end_user, rate_id, end_user_id) if temp_ids.blank?
  end

  def save_notification_rate!(current_end_user, rate_id, visited_id)
    notification = current_end_user.active_notifications.new(
      cocktail_id: id,
      rate_id: rate_id,
      visited_id: visited_id,
      action: 'rate'
    )
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
