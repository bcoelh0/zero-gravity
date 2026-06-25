class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  before_action :load_nav_teachers

  private

  def load_nav_teachers
    @nav_teachers          = Teacher.where(role: :teacher).order(:name)
    @nav_hod               = Teacher.find_by(role: :hod)
    @nav_demo_teacher_id   = cookies[:demo_teacher_id]&.to_i
  end
end
