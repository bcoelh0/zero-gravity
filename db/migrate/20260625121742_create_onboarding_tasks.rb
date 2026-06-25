class CreateOnboardingTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :onboarding_tasks do |t|
      t.string :title
      t.string :description
      t.integer :position

      t.timestamps
    end
  end
end
