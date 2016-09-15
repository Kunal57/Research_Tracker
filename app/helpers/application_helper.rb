module ApplicationHelper
  # helper_method :current_user, :logged_in?, :is_professor?, :is_student?, :is_admin?

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

  def is_admin?
  	Professor.where(is_admin: true).include?(current_user)
  end
end
