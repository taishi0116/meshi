class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController  
  
  
  
  def twitter
    callback_from :twitter
  end

  private

  def callback_from(provider)
    provider = provider.to_s

    @user = User.find_for_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in @user, event: :authentication
      redirect_to request.env['omniauth.origin']
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_session_url
    end
  end
end