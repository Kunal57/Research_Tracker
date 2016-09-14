class SessionsController < ApplicationController

  def new
    @student = Student.new
    @professor = Professor.new
  end

  def create
    student = Student.find_by(email: params[:email])
    professor = Professor.find_by(email: params[:email])
    if student && student.authenticate(params[:password])
      session[:user_id] = student.id
      redirect_to student
    elsif professor && professor.authenticate(params[:password])
      session[:user_id] = professor.id
      redirect_to professor
    else
      flash[:notice] = "Invalid email/password combination, please try again"
      render 'new'
    end
  end

end
