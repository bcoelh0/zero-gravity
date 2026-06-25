class AddClassSetupToTeachers < ActiveRecord::Migration[8.1]
  def change
    add_column :teachers, :subject, :string
    add_column :teachers, :curriculum_level, :string
    add_column :teachers, :topic, :string
  end
end
