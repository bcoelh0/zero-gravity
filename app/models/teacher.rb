class Teacher < ApplicationRecord
  belongs_to :department
  has_many :teacher_task_completions
  has_many :completed_tasks, through: :teacher_task_completions,
           source: :onboarding_task

  enum :role, { teacher: 0, hod: 1 }

  def tasks_completed_count
    teacher_task_completions.count
  end

  def total_tasks
    OnboardingTask.count
  end

  def activation_status
    return :not_started if tasks_completed_count == 0
    return :activated   if tasks_completed_count >= total_tasks
    :in_progress
  end

  def days_since_login
    return nil unless last_login_at
    ((Time.current - last_login_at) / 1.day).round
  end
end
