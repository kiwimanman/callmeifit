class LaunchesController < ApplicationController
  def root
    redirect_to launches_path
  end 
end