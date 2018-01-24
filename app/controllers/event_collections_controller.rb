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
    puts "The length of the key is #{@user.projects.first.readKey.length}"
    request = Net::HTTP::Post.new(url) 
    request["read_key"] = "92prrm43kth6avmd5e8aiq1avi2h1ucg2nig4ja7ondhabmpufmft7gqagov1g9i"#@user.projects.first.readKey
    puts "The length of the hard coded readkey is #{request["read_key"].length}"
    request.body = "{\"measure\":{},\"startDate\":\"2017-11-20\",\"endDate\":\"#{Date.today.to_s}\"}"
    response = http.request(request)

  	string = response.read_body
    puts string
  	parsed = JSON.parse(string)
	  @events = parsed["result"]


  end

  private

  def collection(user)	
  
  end

end
