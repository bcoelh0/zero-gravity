class TeacherTaskCompletion < ApplicationRecord
  belongs_to :teacher
  belongs_to :onboarding_task
end
