class TasksController < ApplicationController
  def show
    @task = OnboardingTask.find(params[:id])
  end
end
