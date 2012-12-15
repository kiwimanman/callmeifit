module ApplicationHelper
  def logged_in?
    @user && @user.id == session['user_id']
  end
end
