class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user

  private

    def require_user
      unless current_user
        redirect_to root_path
      end
    end

end
