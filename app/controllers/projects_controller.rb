require 'uri'
require 'net/http'

class ProjectsController < ApplicationController
before_action :authenticate_user!
  def new
  	@project = Project.new
  end

  def create
  	@user = current_user
  	project = project_params[:projectName]
  	website = project_params[:website]

  	trimmed_response = createProject(project).read_body.tr('{}','')
  	array_response = trimmed_response.split(',')
  	master_key_array = array_response[0].split(':')
  	read_key_array = array_response[1].split(':')
  	write_key_array = array_response[2].split(':')
    
  	master_key = master_key_array[1]
  	read_key = read_key_array[1]
  	write_key = write_key_array[1]
    
  	@user.projects.create(projectName: project,masterKey: master_key,readKey: read_key,writeKey: write_key,website: website)
  	redirect_to dashboard_one_url
  end

  def edit
  end

  def update
  end

  private


  def project_params
  	params.require(:project).permit(:projectName,:website)
  end

  def createProject(projectname)
  	url = URI("https://nestmetricai.herokuapp.com//project/create")

  	http = Net::HTTP.new(url.host, url.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE

	request = Net::HTTP::Post.new(url)
	request.body = "{\"name\":\"#{projectname}\",\"lock_key\":\"Nestmetric@2030\"}"

	response = http.request(request)

  end

end
