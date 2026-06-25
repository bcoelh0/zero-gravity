class TasksController < ApplicationController
  def show
    @task       = OnboardingTask.find(params[:id])
    @teacher    = Teacher.find_by(id: cookies[:demo_teacher_id]) ||
                  Teacher.where(role: :teacher).first
    @completion = @teacher.teacher_task_completions.find_by(onboarding_task: @task)
  end
end
