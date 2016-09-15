class RecordsController < ActionController::Base

	def create
		#Create the new record.
		p "----------------------------------------------------"
		p params
		record = Record.new(params.permit(:hours_worked, :observations, :project_id))
		record.student_id = current_user.id
		p record
		p "----------------------------------------------------"
		if record.save
			@errors = record.errors.full_messages
		end
		redirect_to Project.find(params[:record][:project_id])
	end

end
