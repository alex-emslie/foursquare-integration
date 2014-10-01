class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :current_user

  private

    def require_user
      unless current_user
        redirect_to root_path
      end
    end

    def Foursquare
      def self.search_venues(text)
          client.search_venues(:ll => '36.142064,-86.816086', :query => text)
      end

      def self.client
          @client ||= Foursquare2::Client.new(ENV["FS_APP_ID"], ENV["FS_APP_SECRET"])
      end
    end
end
