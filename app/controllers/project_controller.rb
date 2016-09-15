class ApplicationController < ActionController::Base
  
  def new
  	if true #current_professor
  		@professor = current_professor
  		@students = Student.all
  		@project = Project.new
  	else
  		redirect_to "/"
  	end
  end

  def create
  	if true #current_professor
	  	new_project = Project.new(title: params[:project][:title], hypothesis: params[:project][:hypothesis], summary: params[:project][:summary], time_budget: params[:project][:time_budget])
	  	if new_project.save
	  		p params
	  		# Create a report for each new array of students.
	  		# new_report = Report.new()
	  		redirect_to current_professor
	  	else
	  		#display the error messages.
	  		@errors = new_project.errors.full_messages
	  	end
	else
		redirect_to "/"
	end
  end

end
