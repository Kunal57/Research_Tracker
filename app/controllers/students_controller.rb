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
    @student_unique_projects = unique_projects(@student)
   
  end

  private
  def student_params
    params.require(:student).permit(:name, :email, :password)
  end

  def unique_projects(student)
    unique_records = Record.where(hours_worked: 0)
    student_unique_records = unique_records.where(student_id: student.id)
    if student_unique_records.length > 0 
      student_unique_projects = []
      student_unique_records.each do |unique_project|
        project = Project.find(unique_project.project_id)
        student_unique_projects << project
      end
    end
    student_unique_projects
  end
end
