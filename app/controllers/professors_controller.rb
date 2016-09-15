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

  def secr1t
    if is_admin?
      @admin = Professor.find(session[:professor_id])
      @pending_profs = Professor.pending_profs
      @pending_projects = Project.pending_projects
      if @pending_profs.length == 0 && @pending_projects.length == 0
        @no_pending = true
      end
    else
      403
    end
  end

  def approve
    if is_admin?
      @prof_approved = Professor.find(params[:prof_id])
      @prof_approved.update_column(:is_approved, true)
      redirect_to(:back)
    else
      403
    end
  end


  private
  def professor_params
    params.require(:professor).permit(:name, :email, :password, :is_approved)
  end

end
