class ApplicationController < ActionController::Base
  include JSONAPI::ActsAsResourceController

  before_action :allow_params_authentication!
  # take params, make them into params devise wants to see
  before_action :rewrite_param_names
  # This is our new function that comes before Devise's one
  before_action :attempt_login
  # This is Devise's authentication
  before_action :authenticate_user!

  protect_from_forgery with: :null_session

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[longitude latitude firstname lastname])
  end

  def attempt_login
    email = params[:email].presence
    user = email && User.find_by(email: email)
    return unless user

    sign_in user, store: false if user.valid_password? request.params[:password]
  end

  def rewrite_param_names
    if request.params[:password] && request.params[:email]
      request.params[:user] = { password: request.params[:password], email: request.params[:email] }
    end
  end
end
