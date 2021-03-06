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
    request["read_key"] = @user.projects.first.readKey
    puts request["read_key"]
    puts "The length of the hard coded readkey is #{request["read_key"].length}"
    request.body = "{\"measure\":{},\"startDate\":\"2017-11-20\",\"endDate\":\"#{Date.today.to_s}\"}"
    response = http.request(request)

  	string = response.read_body
  	parsed = JSON.parse(string)
	  @events = parsed["result"]
    puts @events.length
    puts @events.class
    puts "===#{response.read_body}=="

  end

  private

  def collection(user)	
  
  end

end
