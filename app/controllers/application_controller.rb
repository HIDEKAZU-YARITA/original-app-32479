class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configre_permitted_parameters, if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def configre_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number])
  end

  def after_sign_in_path_for(_resource)
    staffs_path
  end
end
