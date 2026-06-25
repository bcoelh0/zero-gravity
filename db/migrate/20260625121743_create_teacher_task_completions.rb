class CreateTeacherTaskCompletions < ActiveRecord::Migration[8.1]
  def change
    create_table :teacher_task_completions do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :onboarding_task, null: false, foreign_key: true
      t.datetime :completed_at

      t.timestamps
    end
  end
end
