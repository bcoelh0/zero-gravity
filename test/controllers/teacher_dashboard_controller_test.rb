require "test_helper"

class TeacherDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get teacher_dashboard_index_url
    assert_response :success
  end
end
