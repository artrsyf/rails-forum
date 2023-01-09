class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :user_activity

  around_action :switch_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |reg| reg.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |reg| reg.permit(:name, :email, :password, :current_password) }
  end

  def user_activity
    current_user.try :touch
  end

  private

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale locale, &action
  end

  def locale_from_url
    locale = params[:locale]

    return locale if I18n.availiable_locales.map(&:to_s).include?(locale)

    nil
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
