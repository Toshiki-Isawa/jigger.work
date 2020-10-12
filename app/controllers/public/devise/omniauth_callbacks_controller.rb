# frozen_string_literal: true

class Public::Devise::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end

  def twitter
    callback_for(:twitter)
  end

  def callback_for(provider)
    @omniauth = request.env['omniauth.auth']
    info = EndUser.find_oauth(@omniauth)
    @end_user = info[:end_user]
    if @end_user.persisted? 
      sign_in_and_redirect @end_user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else 
      @sns = info[:sns]
      redirect_to new_end_user_registration_path
    end
  end

  def failure
    redirect_to root_path and return
  end
end
