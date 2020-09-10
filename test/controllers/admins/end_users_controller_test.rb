require 'test_helper'

class Admins::EndUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_end_users_index_url
    assert_response :success
  end

  test "should get show" do
    get admins_end_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get admins_end_users_edit_url
    assert_response :success
  end

end
