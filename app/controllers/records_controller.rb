class RecordsController < ApplicationController

	def create
		#Create the new record.
    project = Project.find(params[:record][:project_id])
		@record = Record.new(params.require(:record).permit(:hours_worked, :observations, :project_id))
		@record.student_id = current_user.id
		if @record.save
			redirect_to project
    else
      flash[:notice] = "Hours worked must be a positive integer"
      redirect_to project
		end

	end

end
