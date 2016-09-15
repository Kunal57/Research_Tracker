class ProjectsController < ApplicationController
  
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
	  	new_project = Project.new(title: params[:project][:title], hypothesis: params[:project][:hypothesis], summary: params[:project][:summary], time_budget: params[:project][:time_budget], professor_id: current_user)
	  	if new_project.save
	  		# Create a record for each new array of students.
	  		i = 1
	  		while i < params[:students][:ids].length + 1
	  			if params[:students][:ids][i.to_s] == "1"
	  				record = Record.new(project_id: new_project.id, student_id: i)
	  				if !record.save
	  					@errors = record.errors.full_messages
	  				end
	  			end
	  			i += 1
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
