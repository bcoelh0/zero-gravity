class TeacherDashboardController < ApplicationController
  def index
    @teacher     = Teacher.find_by(id: cookies[:demo_teacher_id]) ||
                   Teacher.where(role: :teacher).first
    @tasks       = OnboardingTask.all
    @completions = @teacher.teacher_task_completions
                           .pluck(:onboarding_task_id, :id).to_h
    @active_task = @tasks.find { |t| !@completions.key?(t.id) } || @tasks.first
  end
end
