require 'uri'
require 'net/http'
require 'json'
class EventCollectionsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user
  	string = collection(@user).read_body
  	parsed = JSON.parse(string)
	  @events = parsed["result"]
  end

  private

  def collection(user)	
  url = URI("https://nestmetricai.herokuapp.com///event-explorer/statistics")
  http = Net::HTTP.new(url.host, url.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE

	request = Net::HTTP::Post.new(url)
  puts user.projects.first.readKey
	request["read_key"] = current_user.projects.first.readKey
	request.body = "{\"measure\":{},\"startDate\":\"2017-11-20\",\"endDate\":\"#{Date.today.to_s}\",\"collections\":[\"pageview\"]}"

	response = http.request(request)

  end

end
