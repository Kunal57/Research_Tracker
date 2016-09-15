class RecordsController < ApplicationController

	def create
		#Create the new record.
		record = Record.new(params.require(:record).permit(:hours_worked, :observations, :project_id))
		record.student_id = current_user.id
		if record.save
			@errors = record.errors.full_messages
		end
		redirect_to Project.find(params[:record][:project_id])
	end

end
