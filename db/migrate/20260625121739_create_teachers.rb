class CreateTeachers < ActiveRecord::Migration[8.1]
  def change
    create_table :teachers do |t|
      t.references :department, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.integer :role
      t.datetime :last_login_at

      t.timestamps
    end
  end
end
