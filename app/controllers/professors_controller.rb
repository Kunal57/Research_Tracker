class ProfessorsController < ApplicationController

  def show
    @professor = Professor.find(params[:id])
    @projects = @professor.projects
  end

  def new
    @professor = Professor.new
  end

  def create
    @professor = Professor.new(professor_params)
    if @professor.save
      session[:user_id] = @professor.id
      redirect_to @professor
    else
      @errors = @professor.errors.full_messages
      render 'new'
    end
  end

  private
  def professor_params
    params.require(:professor).permit(:name, :email, :password)
  end

end
