class DashboardController < ApplicationController
  before_action :authenticate_user!
  def new
  	 @user = current_user
  end

  def create
     
  end

  def one
    @user = current_user
    @project = @user.projects.first
    @write_key = @project.writeKey

  end

  def churn
  	 @user = current_user
  end

  def most_valuable
    @user = current_user

    @table = params[:projectName]

    if @table.nil?
      @table = cookies[:table]
    end

    puts "the field posted is \"#{@table}\""
    @project = @user.projects.first
    @project_name = @project.projectName
    @all_keys = []
    ActiveRecord::Base.connection.schema_search_path = "#{@project_name},public"
    puts ActiveRecord::Base.connection.schema_search_path
    @result = ActiveRecord::Base.connection.execute("select * from \"#{@table}\"")
    #I need to paginate
    #this code needs to be re-written
  end
  
  def likely_convert
     @user = current_user
  end

  def churn_onboarding
  	 @user = current_user
  end

  def campaign
       @user = current_user
  end

  def explore
     @user = current_user
  end

  def segment
     @user = current_user
  end

  def create_segment
     @user = current_user
  end

  def compose_segmented
     @user = current_user
  end

  def all_segments
    @user = current_user
  end

  def settings
     @user = current_user
  end

  def emptystate
    @user = current_user
  end

  def segment_empty
     @user = current_user
  end
    
  def new_segment_emptystate
    @user = current_user
  end

  def campaign_segment
    @user = current_user
  end

  def customer
    @user = current_user
  end

  
end
