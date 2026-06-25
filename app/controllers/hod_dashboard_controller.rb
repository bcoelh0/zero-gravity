class HodDashboardController < ApplicationController
  def index
    @hod         = Teacher.find_by(role: :hod)
    @department  = @hod.department
    @teachers    = @department.classroom_teachers.includes(
                     :teacher_task_completions, :completed_tasks
                   )
    @total_tasks = OnboardingTask.count
  end
end
