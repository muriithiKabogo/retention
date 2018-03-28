class CustomersController < ApplicationController
  before_action :authenticate_user!
  def index
  	@user = current_user
  	@project = @user.projects.first
    @project_name = @project.projectName
    ActiveRecord::Base.connection.schema_search_path = "#{@project_name},public"
    puts ActiveRecord::Base.connection.schema_search_path
    @customers = ActiveRecord::Base.connection.execute("select * from \"_users\"")
    @customers.each do |customer|
    	puts customer.keys
    	end
  end
end
