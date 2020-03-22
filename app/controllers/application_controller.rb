class ApplicationController < ActionController::Base
  include JSONAPI::ActsAsResourceController

  before_action :allow_params_authentication!

  protect_from_forgery with: :null_session

  def authenticate_user
    authenticate_or_request_with_http_token do |token, options|
      puts 'HEY'*100
      puts token
      puts options

      @current_user ||= User.find_by(token: token)
    end
  end

  def current_user
    @current_user
  end
end
