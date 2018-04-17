class ApplicationController < ActionController::Base
  include JSONAPI::ActsAsResourceController
  # include Pundit
  protect_from_forgery with: :null_session
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!, :except => [:show, :index]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[longitude latitude firstname lastname])
  end

  def current_user
    id = params[:id] ? params[:id] : 1
    User.find(id)
  end
end
