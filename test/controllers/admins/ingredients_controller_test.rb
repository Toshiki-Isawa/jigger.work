require 'test_helper'

class Admins::IngredientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_ingredients_index_url
    assert_response :success
  end

end
