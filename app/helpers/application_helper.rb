module ApplicationHelper
	def logged_in?
    current_user != nil
  end

  def current_user
    if is_professor?
      Professor.find(session[:professor_id])
    elsif is_student?
      Student.find(session[:student_id])
    else
      nil
    end
  end

  def is_professor?
  	session[:professor_id] != nil
  end

  def is_student?
    session[:student_id] != nil
  end

  def is_admin?
  	Professor.where(is_admin: true).include?(current_user)
  end
end
