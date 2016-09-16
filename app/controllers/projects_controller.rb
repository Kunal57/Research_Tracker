class ProjectsController < ApplicationController


	def index
		@projects = Project.all
	end

	def show
		@record = Record.new
		@student = Student.find_by(id: session[:student_id])
		@project = Project.find(params[:id])
		if @student
			@student_total_hours = @student.hours_per_project(@project.id)
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
	  	@project = Project.new(title: params[:project][:title], hypothesis: params[:project][:hypothesis], summary: params[:project][:summary], time_budget: params[:project][:time_budget], professor_id: current_user.id)
	  	if @project.save
	  		# Create a record for each new array of students.
	  		params[:students][:ids].each do |student_id, checked|
	  			if checked == "1"
	  				@record = Record.new(project_id: @project.id, student_id: student_id)
	  				if !@record.save
              @students = Student.all
	  					render 'new'
	  				end
	  			end
	  		end
	  		# new_report = Report.new()
	  		redirect_to @project
	  	else
	  		#display the error messages.
        @students = Student.all
	  		render 'new'
	  	end
		else
			redirect_to "/"
		end
  end

  def edit
	 if is_professor?
			@students = Student.all
			@project = Project.find(params[:id])
		else
			redirect_to "/"
		end
  end

  def update
  	if is_professor?
  		@project = Project.find(params[:id])
  		@project.update_attributes(title: params[:project][:title], hypothesis: params[:project][:hypothesis], summary: params[:project][:summary], time_budget: params[:project][:time_budget])
  		@project.records.destroy
  		# Create a record for each new array of students.
	  		params[:students][:ids].each do |student_id, checked|
	  			if checked == "1"
	  				@record = Record.new(project_id: @project.id, student_id: student_id)
	  				if !@record.save
              @students = Student.all
	  					render 'new'
	  				end
	  			end
	  		end
	  	redirect_to @project
  	end
  end

  def delete
  	 if is_professor?
  		@project = Project.find(params[:id])
  		@records = @project.records
  		@project.destroy
  		@records.destroy
  		redirect_to "/"
  	else
  		redirect_to "/"
  	end
  end

  def admin
    if is_admin? && params[:commit] == 'Approve this Proposal'
      @proj_approved = Project.find(params[:project_id])
      @proj_approved.update_column(:status, 'active')
      redirect_to(:back)
    elsif is_admin? && params[:commit] == 'Reject this Proposal'
      @proj_approved = Project.find(params[:project_id])
      @proj_approved.update_column(:status, 'rejected')
      redirect_to(:back)
    else
      403
    end
  end

end
