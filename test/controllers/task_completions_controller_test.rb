require "test_helper"

class TaskCompletionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get task_completions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get task_completions_destroy_url
    assert_response :success
  end
end
