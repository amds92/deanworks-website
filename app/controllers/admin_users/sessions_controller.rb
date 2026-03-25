class AdminUsers::SessionsController < Devise::SessionsController
  layout "admin_login"

  private

  def after_sign_in_path_for(_resource)
    admin_root_path
  end
end
