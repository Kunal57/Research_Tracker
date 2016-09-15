class ProfessorsController < ApplicationController

  def show
    @professor = Professor.find(params[:id])
    @pending_projects = @professor.pending_projects
    @active_projects = @professor.active_projects
    @completed_projects = @professor.completed_projects
    @rejected_projects = @professor.rejected_projects
  end

  def new
    @professor = Professor.new
  end

  def create
    @professor = Professor.new(professor_params)
    if @professor.save
      session[:professor_id] = @professor.id
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
