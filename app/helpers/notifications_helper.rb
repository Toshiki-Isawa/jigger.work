module NotificationsHelper

  def notification_form(notification)
    @visiter = notification.visiter
    @rate = nil
    your_cocktail = link_to 'あなたの投稿', public_cocktail_path(notification), style:"font-weight: bold;"
    @visiter_rate = notification.rate_id
    #notification.actionがfollowかlikeかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.visiter.name, href:public_end_user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
      when "like" then
        tag.a(notification.visiter.name, href:public_end_user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:public_cocktail_path(notification.cocktail_id), style:"font-weight: bold;")+"にいいねしました"
      when "rate" then
        @rate = Rate.find_by(id: @visiter_rate)&.comment
        tag.a(@visiter.name, href:public_end_user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:public_cocktail_path(notification.cocktail_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end

end
