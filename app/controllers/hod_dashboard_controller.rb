class HodDashboardController < ApplicationController
  def index
    @hod         = Teacher.find_by(role: :hod)
    @department  = @hod.department
    @teachers    = @department.classroom_teachers.includes(
                     :teacher_task_completions, :completed_tasks
                   )
    @total_tasks = OnboardingTask.count
    @all_tasks   = OnboardingTask.order(:position)

    completed_task_ids_by_teacher = @teachers.each_with_object({}) do |teacher, h|
      h[teacher.id] = teacher.teacher_task_completions.map(&:onboarding_task_id).to_set
    end
    @next_task_by_teacher = @teachers.each_with_object({}) do |teacher, h|
      h[teacher.id] = @all_tasks.find { |t| !completed_task_ids_by_teacher[teacher.id].include?(t.id) }
    end
  end
end
