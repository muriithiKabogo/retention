require 'uri'
require 'net/http'
require 'json'

class EventCollectionsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user
    url = URI("https://nestmetricai.herokuapp.com///event-explorer/statistics")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url) 
    request["read_key"] = @user.projects.first.readKey.to_s #{}"92prrm43kth6avmd5e8aiq1avi2h1ucg2nig4ja7ondhabmpufmft7gqagov1g9i"
    request.body = "{\"measure\":{},\"startDate\":\"2017-11-20\",\"endDate\":\"#{Date.today.to_s}\"}"
    response = http.request(request)

  	string = response.read_body
  	parsed = JSON.parse(string)
	  @events = parsed["result"]

    puts "The key is #{@user.projects.first.readKey.class}"
  end

  private

  def collection(user)	
  
  end

end
