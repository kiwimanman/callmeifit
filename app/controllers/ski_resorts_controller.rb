class SkiResortsController < ApplicationController
  def index
    @resorts = SkiResort.all
  end
end
