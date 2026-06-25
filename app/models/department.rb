class Department < ApplicationRecord
  belongs_to :school
  has_many :teachers

  def hod
    teachers.find_by(role: :hod)
  end

  def classroom_teachers
    teachers.where(role: :teacher)
  end
end
