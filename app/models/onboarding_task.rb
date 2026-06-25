class OnboardingTask < ApplicationRecord
  default_scope { order(:position) }
  has_many :teacher_task_completions
end
