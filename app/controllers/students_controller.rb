class StudentsController < ApplicationController
  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      session[:user_id] = @student.id
      redirect_to @student
    else
      @errors = @student.errors.full_messages
      render "new"
    end
  end


  private
  def student_params
    params.require(:student).permit(:name, :email, :password)
  end
end
