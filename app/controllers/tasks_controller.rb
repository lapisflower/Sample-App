class TasksController < ApplicationController
  def index
    @tasks = @user.tasks
  end
  
  def new
    @task = Task.new
  end
end

