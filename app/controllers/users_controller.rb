class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :require_logged_in_user
  before_action :require_admin, except: :show

  def show
    @user = @users.first
  end

  def index

  end
end
