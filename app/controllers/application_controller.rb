class ApplicationController < ActionController::Base
  before_action :configre_permitted_parameters, if: :devise_controller?

  private

  def configre_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number])
  end

  def after_sign_in_path_for(resource) 
    staffs_path
  end
end
