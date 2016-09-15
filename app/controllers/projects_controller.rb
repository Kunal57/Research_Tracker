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

  def new
  	if is_professor?
  		#@professor = current_professor
  		@students = Student.all
  		@project = Project.new
  	else
  		redirect_to "/"
  	end
  end

  def create
  	if is_professor?
	  	new_project = Project.new(title: params[:project][:title], hypothesis: params[:project][:hypothesis], summary: params[:project][:summary], time_budget: params[:project][:time_budget], professor_id: current_user.id)
	  	if new_project.save
	  		# Create a record for each new array of students.
	  		params[:students][:ids].each do |student_id, checked|
	  			if checked == "1"
	  				record = Record.new(project_id: new_project.id, student_id: student_id)
	  				if !record.save
	  					@errors = record.errors.full_messages
	  				end
	  			end
	  		end
	  		# new_report = Report.new()
	  		redirect_to new_project
	  	else
	  		#display the error messages.
	  		@errors = new_project.errors.full_messages
	  	end
	else
		redirect_to "/"
	end
  end

end
