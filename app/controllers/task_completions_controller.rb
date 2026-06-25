class TaskCompletionsController < ApplicationController
  def create
    @teacher        = Teacher.find(params[:teacher_id])
    @completed_task = OnboardingTask.find(params[:onboarding_task_id])

    completion = @teacher.teacher_task_completions.find_or_create_by(
      onboarding_task: @completed_task
    ) { |c| c.completed_at = Time.current }
    @completion_id = completion.id

    @teacher.update(last_login_at: Time.current)

    if params.key?(:weekly_email_opted_in)
      @teacher.update(weekly_email_opted_in: params[:weekly_email_opted_in] == "true")
    end

    all_tasks        = OnboardingTask.all
    new_completions  = @teacher.teacher_task_completions.pluck(:onboarding_task_id, :id).to_h
    @next_task       = all_tasks.find { |t| !new_completions.key?(t.id) }
    @completed_count = new_completions.count
    @total_count     = all_tasks.count
    @pct             = @total_count > 0 ? (@completed_count.to_f / @total_count * 100).round : 0

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to teacher_dashboard_path }
    end
  end

  def destroy
    completion        = TeacherTaskCompletion.find(params[:id])
    @uncompleted_task = completion.onboarding_task
    @teacher          = completion.teacher
    completion.destroy

    @all_tasks       = OnboardingTask.all
    new_completions  = @teacher.teacher_task_completions.pluck(:onboarding_task_id, :id).to_h
    @new_completions = new_completions
    @active_task     = @all_tasks.find { |t| !new_completions.key?(t.id) } || @all_tasks.first
    @completed_count = new_completions.count
    @total_count     = @all_tasks.count
    @pct             = @total_count > 0 ? (@completed_count.to_f / @total_count * 100).round : 0

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to teacher_dashboard_path }
    end
  end
end
