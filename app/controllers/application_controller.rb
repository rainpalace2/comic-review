class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # 一部のページをアクセス制限の対象から除外する
  # オプションとしてexcept: [:アクション名]を使用することでそのアクションははログイン前でもアクセス可能。
  #before_action :authenticate_customer!, except: [:top, :about]
  before_action :authenticate_admin!, if: :admin_url
  before_action :authenticate_customer!, if: :public_url
  
  def admin_url
    request.fullpath.include?("/admin")
  end
  
  def public_url
    request.path.include?("/public")
  end
  
  # def after_sign_up_path_for(resource)
  #   root_path
  # end

  # def after_sign_in_path_for(resource)
  #   root_path
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
