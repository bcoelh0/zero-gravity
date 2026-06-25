require "test_helper"

class HodDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hod_dashboard_index_url
    assert_response :success
  end
end
