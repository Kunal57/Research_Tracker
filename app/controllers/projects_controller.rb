class ProjectsController < ApplicationController

	def index
    if logged_in?
		  @projects = Project.all
    else
      flash[:access] = "Unauthorized access, please contact your administrator if you believe this error is incorrect."
      if request.env["HTTP_REFERER"].present?
        redirect_to :back
      else
        redirect_to root_path
      end
    end
	end

	def show
		@record = Record.new
		@student = Student.find_by(id: session[:student_id])
		@project = Project.find(params[:id])
		@students = Student.all
		@records = @project.records.where.not(hours_worked: 0)

    if logged_in? && @project.authorized_viewer?(current_user)
      @project_logs = @project.records.where.not(hours_worked: 0)
  		if @student
  			@student_total_hours = @student.hours_per_project(@project.id)
  		end
    else
      flash[:access] = "Unauthorized access, please contact your administrator if you believe this error is incorrect."
      if request.env["HTTP_REFERER"].present?
        redirect_to :back
      else
        redirect_to projects_path
      end
    end
	end

  def new
  	if is_professor?
  		#@professor = current_professor
  		@students = Student.all
  		@project = Project.new
  	else
  		flash[:access] = "Unauthorized access, please contact your administrator if you believe this error is incorrect."
      if request.env["HTTP_REFERER"].present?
        redirect_to :back
      else
        redirect_to projects_path
      end
  	end
  end

  def create
  	if is_professor?
  		restricted_params = restrict(params)
	  	@project = Project.new(restricted_params)
	  	@project.professor_id = current_user.id
	  	if @project.save
	  		# Create a record for each new array of students.
	  		params[:students][:ids].each do |student_id, checked|
	  			if checked == "1"
	  				@record = Record.new(project_id: @project.id, student_id: student_id)
	  				# if !@record.save
	       				# @students = Student.all
		  				# render 'new'
	  				# end
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
		flash[:access] = "Unauthorized access, please contact your administrator if you believe this error is incorrect."
    if request.env["HTTP_REFERER"].present?
      redirect_to :back
    else
      redirect_to projects_path
    end
	 end
  end

  def edit
    if @project.professor.id == current_user.id
			@students = Student.all
			@project = Project.find(params[:id])
		else
			flash[:access] = "Unauthorized access, please contact your administrator if you believe this error is incorrect."
      if request.env["HTTP_REFERER"].present?
        redirect_to :back
      else
        redirect_to projects_path
      end
		end
  end

  def update
  		@project = Project.find(params[:id])
    if @project.professor.id == current_user.id
  		@project.update_attributes(title: params[:project][:title], hypothesis: params[:project][:hypothesis], summary: params[:project][:summary], time_budget: params[:project][:time_budget])
  		@records = @project.records
      @records.destroy_all
  		# Create a record for each new array of students.
	  		params[:students][:ids].each do |student_id, checked|
	  			if checked == "1"
	  				@record = Record.new(project_id: @project.id, student_id: student_id)
	  			end
	  		end
	  	redirect_to @project
    else
      flash[:access] = "Unauthorized access, please contact your administrator if you believe this error is incorrect."
      if request.env["HTTP_REFERER"].present?
        redirect_to :back
      else
        redirect_to projects_path
      end
  	end
  end

  def destroy
  		@project = Project.find(params[:id])
    if @project.professor.id == current_user.id
  		@records = @project.records
  		@project.destroy
  		@records.destroy
  		redirect_to current_user
  	else
  		flash[:access] = "Unauthorized access, please contact your administrator if you believe this error is incorrect."
      if request.env["HTTP_REFERER"].present?
        redirect_to :back
      else
        redirect_to projects_path
      end
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
      flash[:access] = "Unauthorized access, please contact your administrator if you believe this error is incorrect."
      if request.env["HTTP_REFERER"].present?
        redirect_to :back
      else
        redirect_to projects_path
      end
    end
  end

  def complete
  	project = Project.find(params[:id])
  	project.update_attributes(status: "complete")
  	redirect_to project
  end

  def team_update
  	@project = Project.find(params[:project_id])

  	zero_records = @project.records.where(hours_worked: 0)
  	zero_records.destroy_all

  	team_update_params["student_ids"].each do |id|
  		Record.create(student_id: id, project_id: @project.id)
  	end
  	
  	redirect_to @project
  end
  
  private
  def team_update_params
  	params.require(:project).permit(:student_ids => [])
  end

  def restrict(params)
  	params.require(:project).permit(:title, :hypothesis, :summary, :time_budget)
  end

end
