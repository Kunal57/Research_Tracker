class StudentsController < ApplicationController
  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      session[:student_id] = @student.id
      redirect_to @student
    else
      @errors = @student.errors.full_messages
      render "new"
    end
  end

  def show
    @student = Student.find(params[:id])
    if current_user.id = @student.id
      @projects = @student.projects
      @hours = @student.total_hours_worked
    else
      flash[:access] = "Unauthorized access, please contact your administrator if you believe this error is incorrect."
      if request.env["HTTP_REFERER"].present?
        redirect_to :back
      else
        redirect_to @projects
      end
    end
  end

  private
  def student_params
    params.require(:student).permit(:name, :email, :password)
  end
end
