class UsersController < ApplicationController
  before_filter :require_logged_in_user

  http_basic_authenticate_with name: ENV['HTTP_USER'], password: ENV['HTTP_PASSWORD'], only: :index if Rails.env.production?

  def all
    @users = User.all
  end
end