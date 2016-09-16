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
    @hours = @student.total_hours_worked
    @student_unique_projects = @student.unique_projects
  end

  private
  def student_params
    params.require(:student).permit(:name, :email, :password)
  end
end
