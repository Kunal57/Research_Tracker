class ApplicationController < ActionController::Base
  
  def new
  	if true #current_professor
  		@professor = current_professor
  		@students = Student.all
  		@project = Project.new
  	else
  		redirect_to "/"
  	end
  end

end