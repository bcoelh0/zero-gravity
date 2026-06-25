class AddWeeklyEmailOptedInToTeachers < ActiveRecord::Migration[8.1]
  def change
    add_column :teachers, :weekly_email_opted_in, :boolean
  end
end
