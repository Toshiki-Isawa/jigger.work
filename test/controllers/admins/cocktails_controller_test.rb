require 'test_helper'

class Admins::CocktailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_cocktails_index_url
    assert_response :success
  end

  test "should get new" do
    get admins_cocktails_new_url
    assert_response :success
  end

  test "should get show" do
    get admins_cocktails_show_url
    assert_response :success
  end

  test "should get edit" do
    get admins_cocktails_edit_url
    assert_response :success
  end

end
