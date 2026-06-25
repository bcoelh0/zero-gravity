puts "Seeding Zero Gravity demo data..."

TeacherTaskCompletion.destroy_all
OnboardingTask.destroy_all
Teacher.destroy_all
Department.destroy_all
School.destroy_all

# School
school = School.create!(name: "Oakwood Academy")

# Departments
maths = Department.create!(school: school, name: "Mathematics")
Department.create!(school: school, name: "English")
Department.create!(school: school, name: "Sciences")

# Onboarding tasks
tasks = OnboardingTask.create!([
  {
    position: 1,
    title: "Set up your first class's subject",
    description: "Your classes are already here — just confirm the subject and curriculum level so the AI tutor knows what to focus on."
  },
  {
    position: 2,
    title: "Assign your first topic",
    description: "Pick a topic you're covering this half-term. The AI tutor will align revision and practice to it."
  },
  {
    position: 3,
    title: "Check a student report",
    description: "Open any student's progress report. See where they're strong and where they need support."
  },
  {
    position: 4,
    title: "Share the AI Tutor with your students",
    description: "Send students their join link — takes 2 minutes. Once they're in, you'll see their activity here."
  },
  {
    position: 5,
    title: "Set a weekly check-in reminder",
    description: "Block 5 minutes every Monday to review your class's progress. This is the habit that makes Zero Gravity stick."
  }
])

t1, t2, t3, t4, t5 = tasks

# HoD — Claire Ashworth
claire = Teacher.create!(
  department: maths, name: "Claire Ashworth",
  email: "c.ashworth@oakwood.ac.uk", role: :hod,
  last_login_at: 1.hour.ago
)

# Dan — fully activated (all 5 tasks, logged in today)
dan = Teacher.create!(
  department: maths, name: "Daniel Osei",
  email: "d.osei@oakwood.ac.uk", role: :teacher,
  last_login_at: 2.hours.ago,
  subject: "Mathematics", curriculum_level: "GCSE", topic: "Quadratic equations",
  weekly_email_opted_in: true
)
[t1, t2, t3, t4, t5].each do |t|
  TeacherTaskCompletion.create!(teacher: dan, onboarding_task: t, completed_at: rand(1..3).days.ago)
end

# Priya — in progress (3/5 tasks, logged in yesterday)
priya = Teacher.create!(
  department: maths, name: "Priya Mehta",
  email: "p.mehta@oakwood.ac.uk", role: :teacher,
  last_login_at: 1.day.ago,
  subject: "Mathematics", curriculum_level: "A-Level", topic: "Trigonometry"
)
[t1, t2, t3].each do |t|
  TeacherTaskCompletion.create!(teacher: priya, onboarding_task: t, completed_at: rand(2..4).days.ago)
end

# James — barely started (1/5, logged in 4 days ago and went quiet)
james = Teacher.create!(
  department: maths, name: "James Whitfield",
  email: "j.whitfield@oakwood.ac.uk", role: :teacher,
  last_login_at: 4.days.ago
)
TeacherTaskCompletion.create!(teacher: james, onboarding_task: t1, completed_at: 4.days.ago)

# Sara — not started, never logged in
sara = Teacher.create!(
  department: maths, name: "Sara Johansson",
  email: "s.johansson@oakwood.ac.uk", role: :teacher,
  last_login_at: nil
)

# Tom — not started, logged in once 6 days ago but did nothing
tom = Teacher.create!(
  department: maths, name: "Tom Brennan",
  email: "t.brennan@oakwood.ac.uk", role: :teacher,
  last_login_at: 6.days.ago
)

puts "Seeded: #{Teacher.count} teachers, #{OnboardingTask.count} tasks, #{TeacherTaskCompletion.count} completions"
puts ""
puts "=== DEMO URLS ==="
puts "Teacher — Sara (blank slate, most dramatic):  http://localhost:3000/t/dash?teacher_id=#{sara.id}"
puts "Teacher — Priya (in progress, 3/5):           http://localhost:3000/t/dash?teacher_id=#{priya.id}"
puts "Teacher — Dan (fully activated):              http://localhost:3000/t/dash?teacher_id=#{dan.id}"
puts "HoD     — Claire's department view:           http://localhost:3000/hod/dash"
