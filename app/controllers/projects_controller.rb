require 'uri'
require 'net/http'
require 'json'
class ProjectsController < ApplicationController
before_action :authenticate_user!
  def new
    @user = current_user
    if @user.projects.exists?
      redirect_to  event_collections_index_url
    else
  	   @project = Project.new
    end
  end

  def create
    
    	@user = current_user
    	project = project_params[:projectName]
    	website = project_params[:website]

    	string= createProject(project).read_body
      parsed = JSON.parse(string)

    	master_key = parsed["master_key"]
    	read_key = parsed["read_key"]
    	write_key = parsed["write_key"]
      
    	@user.projects.create(projectName: project,masterKey: master_key,readKey: read_key,writeKey: write_key,website: website)
      flash[:success] = "Project created"
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
