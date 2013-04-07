module ApplicationHelper
  def logged_in?
    @logged_in_user && @logged_in_user.id == session['user_id']
  rescue
		nil
	end
end
