class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :current_user

  private

    def require_user
      unless current_user
        redirect_to root_path
      end
    end

    def foursquare
        @foursquare ||= Foursquare::Base.new(ENV["FS_APP_ID"], ENV["FS_APP_SECRET"])
    end

end
