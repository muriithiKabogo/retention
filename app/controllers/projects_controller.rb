require 'uri'
require 'net/http'
require 'json'
class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def analyze
    @user = current_user
    @events = get_events
  end

  def get_event_poperties
    event_poperties = get_event(params[:event_name])
    respond_to do |format|
     format.json { render json: event_poperties.to_json }
    end
  end

  def search
    project_name = current_user.projects.first.projectName
    query = params[:sql]
    ActiveRecord::Base.connection.schema_search_path = "#{project_name},public"
    @result = ActiveRecord::Base.connection.execute(query).to_a
    @all_keys = []
    html = render_to_string(:partial => "search_result", layout: false, locals: {result: @result, all_keys: @all_keys})
    respond_to do |format|
     format.json { render json: html.to_json }
    end
  end

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

  # desc: return array of column names of table
  # @return: array 
  def get_event(event_name, project_name=nil)
    project_name ||= current_user.projects.first.projectName
    sql = "SELECT column_name, data_type  FROM information_schema.columns where table_schema = '#{project_name.downcase}' and table_name = '#{event_name.downcase}'"
    ActiveRecord::Base.connection.execute(sql).to_a
  end

  def get_events
    url = URI("https://nestmetricai.herokuapp.com///event-explorer/statistics")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(url) 
    request["read_key"] = current_user.projects.first.readKey
    request.body = "{\"measure\":{},\"startDate\":\"2017-11-20\",\"endDate\":\"#{Date.today.to_s}\"}"
    response = http.request(request)
    string = response.read_body
    JSON.parse(string)["result"].to_h.keys
  end


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
