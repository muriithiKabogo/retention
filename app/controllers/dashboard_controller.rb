class DashboardController < ApplicationController
  before_action :authenticate_user!
  def new
  	
  end

  def one
    @user = current_user
    @project = @user.projects.first
    @write_key = @project.writeKey

  end

  def churn
  	
  end

  def most_valuable
    @user = current_user
    @project = @user.projects.first
    @project_name = @project.projectName
    ActiveRecord::Base.connection.schema_search_path = "#{@project_name},public"
    puts ActiveRecord::Base.connection.schema_search_path
    result = ActiveRecord::Base.connection.execute("select * from pageview")
  end
  def likely_convert

  end

  def churn_onboarding
  	
  end

  def campaign

  end

  def explore
    
  end

  def segment
    
  end

  def create_segment
    
  end

  def compose_segmented

  end

  def all_segments
    
  end

  def settings
  end

  def emptystate
    
  end

  def segment_empty

  end

  def new_segment_emptystate
    
  end

  def campaign_segment
    
  end

  def customer
    
  end

  
end
