class DemoSessionsController < ApplicationController
  def create
    if params[:teacher_id].present?
      cookies[:demo_teacher_id] = { value: params[:teacher_id], expires: 1.day.from_now }
      redirect_to teacher_dashboard_path
    else
      redirect_to hod_dashboard_path
    end
  end
end
