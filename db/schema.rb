# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_06_25_134554) do
  create_table "departments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "school_id", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_departments_on_school_id"
  end

  create_table "onboarding_tasks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.integer "position"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "teacher_task_completions", force: :cascade do |t|
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.integer "onboarding_task_id", null: false
    t.integer "teacher_id", null: false
    t.datetime "updated_at", null: false
    t.index ["onboarding_task_id"], name: "index_teacher_task_completions_on_onboarding_task_id"
    t.index ["teacher_id"], name: "index_teacher_task_completions_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "curriculum_level"
    t.integer "department_id", null: false
    t.string "email"
    t.datetime "last_login_at"
    t.string "name"
    t.integer "role"
    t.string "subject"
    t.string "topic"
    t.datetime "updated_at", null: false
    t.boolean "weekly_email_opted_in"
    t.index ["department_id"], name: "index_teachers_on_department_id"
  end

  add_foreign_key "departments", "schools"
  add_foreign_key "teacher_task_completions", "onboarding_tasks"
  add_foreign_key "teacher_task_completions", "teachers"
  add_foreign_key "teachers", "departments"
end
