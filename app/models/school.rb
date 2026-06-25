class School < ApplicationRecord
  has_many :departments
  has_many :teachers, through: :departments
end
