class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_filter :authenticate_user_from_token!
  before_action :authenticate_user!

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  private

  def authenticate_user_from_token!
    user_email = request.headers["X-API-EMAIL"].presence
    user_auth_token = request.headers["X-API-TOKEN"].presence
    return if user_email.blank? || user_auth_token.blank?

    # TO generate: SecureRandom.urlsafe_base64(25)

    user = User.find_by_email(user_email)

    if user && Devise.secure_compare(user.authentication_token, user_auth_token)
      sign_in user, store: false
    end
  end
end
