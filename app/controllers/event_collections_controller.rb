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
    request["read_key"] =  @user.projects.first.readKey
    puts "the readKey is"
    puts request["read_key"]
    request.body = "{\"measure\":{},\"startDate\":\"2017-11-20\",\"endDate\":\"#{Date.today.to_s}\"}"
    puts "this is the request body"
    puts request.read_body
    response = http.request(request)

  	string = response.read_body
  	parsed = JSON.parse(string)
	  @events = parsed["result"]

  end

  private

  def collection(user)	
  
  end

end
