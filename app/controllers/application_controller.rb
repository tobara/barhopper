class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def authorize_admin!
    if current_user.nil? || !current_user.admin?
      flash[:notice] = "You are not authorized to view this resource."
      redirect_to root_path
    end
  end

  def after_sign_in_path_for(_resource)
    bars_path(current_user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(
        :username, :email, :password, :password_confirmation
      )
    end

    devise_parameter_sanitizer.for(:account_update) << [:username]

    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:username, :email, :password, :remember_me)
    end
  end
end
