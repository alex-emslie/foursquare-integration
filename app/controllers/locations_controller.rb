class LocationsController < ActionController::Base
  include Foursquare2

  def search
    q = params[:query]
    @results = search_venues(q)["venues"].to_json
    render layout: "application"
  end

  private

  def search_venues(q)
      client.search_venues(:ll => '37.792808, -122.402047', :query => q, :v => '20140204', :radius => 1000, :limit => 5)
  end

  def client
      @client ||= Foursquare2::Client.new(:client_id => ENV["FS_APP_ID"], :client_secret => ENV["FS_APP_SECRET"])
  end

end
