class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :user_activity

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
end
