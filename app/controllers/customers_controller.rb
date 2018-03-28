require 'uri'
require 'net/http'
require 'json'

class CustomersController < ApplicationController
  before_action :authenticate_user!
  def index
  	@user = current_user
  	@project = @user.projects.first
    @project_name = @project.projectName
    ActiveRecord::Base.connection.schema_search_path = "#{@project_name},public"
    puts ActiveRecord::Base.connection.schema_search_path
    @customers = ActiveRecord::Base.connection.execute("select * from \"_users\"")

  end

  def customer360
  	@user = current_user
  	@email = params[:email]
  	url = URI("https://app.rakam.io//user/get_events")

	http = Net::HTTP.new(url.host, url.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE

	request = Net::HTTP::Post.new(url)
	request["read_key"] = @user.projects.first.readKey
	request.body = "{\"user\":\"#{@email}\"}"
	response = http.request(request)
	string = response.read_body
  	parsed = JSON.parse(string)
	puts parsed.class
	puts parsed
  end
end
