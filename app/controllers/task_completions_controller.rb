class TaskCompletionsController < ApplicationController
  def create
    teacher = Teacher.find(params[:teacher_id])
    task    = OnboardingTask.find(params[:onboarding_task_id])

    teacher.teacher_task_completions.find_or_create_by(
      onboarding_task: task
    ) { |c| c.completed_at = Time.current }

    teacher.update(last_login_at: Time.current)

    redirect_to teacher_dashboard_path
  end

  def destroy
    completion = TeacherTaskCompletion.find(params[:id])
    completion.destroy

    redirect_to teacher_dashboard_path
  end
end
