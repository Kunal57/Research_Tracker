module ApplicationHelper
	def logged_in?
    session[:user_id] != nil
  end

  def current_user
     User.find(session[:user_id])
  end

  def is_professor?
  	Professor.all.include?(current_user)
  end

  def is_student?
  	Student.all.include?(current_user)
  end
end
