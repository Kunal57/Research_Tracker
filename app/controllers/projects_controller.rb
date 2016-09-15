class ProjectsController < ApplicationController

	def index
		@projects = Project.all 
	end 

	def show
		@record = Record.new
		@project = Project.find(params[:id])
		if is_student?
			@student_total_hours = current_user.hours_per_project(@project.id)
		end
	end
end