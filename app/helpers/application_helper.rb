module ApplicationHelper
  def logged_in?
    @logged_in_user && @logged_in_user.id == session['user_id']
	end

  def logged_in_user
    @logged_in_user = User.where(id: session[:user_id]).first unless session[:user_id].blank?
  end
end
